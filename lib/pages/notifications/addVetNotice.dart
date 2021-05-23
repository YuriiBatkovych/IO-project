import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';  // for formatting appointmentDate
import 'package:pet_app/classes/notification.dart';

import 'package:pet_app/database_helper.dart';

import 'package:pet_app/sharedPreferences.dart' as ntfSerialNumber;
import 'package:pet_app/localNotifyManager.dart';

class addVetNotice extends StatefulWidget {
  @override
  _addVetNoticeState createState() => _addVetNoticeState();
}

class _addVetNoticeState extends State<addVetNotice> {

  DateFormat appointmentDateFormatter = DateFormat('dd-MM-yyyy');
  bool showTextInsteadOfDate = true; // true- show text; false-show date
  final NoticeVet vetNotification = NoticeVet();

  // for choosing date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
       // locale : const Locale("pl","PL"),
        initialDate: vetNotification.date,
        firstDate: DateTime.now(),
        lastDate: vetNotification.date.add(Duration(days:365*5)),
    );
    if (pickedDate != null && pickedDate != vetNotification.date)
      setState(() {
        vetNotification.date = pickedDate;
        showTextInsteadOfDate = false;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meeting with the vet'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                          // borderRadius: BorderRadius.circular(25.0),  // circled box
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          // borderRadius: BorderRadius.circular(25.0),  // circled box
                        ),
                        hintText: 'Description',
                        // hintStyle: TextStyle(
                        //   fontFamily: 'Comfortaa',
                        //   fontSize: 13.0,
                        // ),
                      ),
                      /// keyboardType: TextInputType.number,  // keyboard display numbers


                      onChanged: (val) {
                        setState(() {
                          vetNotification.infoText = val;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Vaccination'
                        ),
                        Switch(
                          activeColor: Colors.lightBlueAccent,
                          value: vetNotification.vaccination,
                          onChanged: (val){
                            setState(() {
                              vetNotification.vaccination = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Date'
                        ),
                        TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              '${showTextInsteadOfDate ? 'choose date' : appointmentDateFormatter.format(vetNotification.date)}',
                              style: TextStyle(color: Colors.blue),
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Remind ',
                        ),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text("1 day before"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("2 days before"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                  child: Text("3 days before"),
                                  value: 3
                              ),
                              DropdownMenuItem(
                                  child: Text("one week before"),
                                  value: 7
                              ),
                            ],
                          value: vetNotification.remindTime,
                          onChanged: (val) {
                            setState(() {
                              vetNotification.remindTime = val;
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                    onPressed: () async {
                      // the notification is displaying at 0:00

                      int serialNumber = await ntfSerialNumber.getCounter();

                      //adding notification do the database
                      int i = await DatabaseHelper.instance.insert('NoticeVet',{
                        'infoText' : vetNotification.infoText,
                        'remindTime' : vetNotification.remindTime,
                        'appointmentDate' : vetNotification.date.toString(),
                        'vaccination' : (vetNotification.vaccination ? 1 : 0),
                        'fromPetType' : DatabaseHelper.instance.animal,
                        'fromPetId' : DatabaseHelper.instance.animalId,
                        'serialNumber' : serialNumber
                      });

                      //adding notification do the LocalNotifyManager
                      LocalNotifyManager.instance.showNotificationScheduled(
                          id: serialNumber,
                          title: 'Weterynarz - ${DatabaseHelper.instance.animalName}',
                          body: vetNotification.infoText,
                          notificationDate: vetNotification.date.subtract(Duration(days: vetNotification.remindTime))
                      );

                      //incrementing serialNumber counter
                      await ntfSerialNumber.incrementCounter();

                      print('databaseHelper: $i');

                      setState(() {
                        Navigator.pushNamedAndRemoveUntil(context, '/notificationPage', ModalRoute.withName('/petPage${DatabaseHelper.instance.animal}'));
                      });
                    },
                    child: Text(
                      'Add notification'
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.black,
                      shadowColor: Colors.blue[900],
                      elevation: 3.0,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
