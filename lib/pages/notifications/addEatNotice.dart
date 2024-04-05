import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:pet_app/classes/notification.dart';

import 'package:pet_app/database_helper.dart';

import 'package:pet_app/sharedPreferences.dart' as ntfSerialNumber;
import 'package:pet_app/localNotifyManager.dart';

class addEatNotice extends StatefulWidget {
  @override
  _addEatNoticeState createState() => _addEatNoticeState();
}

class _addEatNoticeState extends State<addEatNotice> {

  bool showTextInsteadOfDate = true; // true- show text; false-show date
  final NoticeEat eatNotification = NoticeEat();

  // for choosing date
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    if (pickedTime != null)
      setState(() {
        eatNotification.time = pickedTime;
        showTextInsteadOfDate = false;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Eating time'
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
                        eatNotification.infoText = val;
                      });
                    },
                  ),
                    Row(
                      children: [
                        Text(
                            'Remind everyday'
                        ),
                        Switch(
                          activeColor: Colors.lightBlueAccent,
                          value: eatNotification.everyDay,
                          onChanged: (val){
                            setState(() {
                              eatNotification.everyDay = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            'Remind at '
                        ),
                        TextButton(
                            onPressed: () => _selectTime(context),
                            child: Text(
                              '${showTextInsteadOfDate ? 'choose time' : eatNotification.time.format(context)}',
                              style: TextStyle(color: Colors.blue),
                            )
                        ),
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
                      int serialNumber = await ntfSerialNumber.getCounter();

                      //adding notification do the database
                      int i = await DatabaseHelper.instance.insert('NoticeEat', {
                        'infoText' : eatNotification.infoText,
                        'time' : eatNotification.time.format(context),
                        'everyDay' : (eatNotification.everyDay ? 1 : 0),
                        'fromPetType' : DatabaseHelper.instance.animal,
                        'fromPetId' : DatabaseHelper.instance.animalId,
                        'serialNumber' : serialNumber
                      });

                      //adding notification do the LocalNotifyManager
                      if(eatNotification.everyDay) {
                        //daily notification
                        LocalNotifyManager.instance.showNotificationDailyAtTime(
                            id: serialNumber,
                            title: 'Eating - ${DatabaseHelper.instance.animalName}',
                            body: eatNotification.infoText,
                            notificationTime: Time(eatNotification.time.hour, eatNotification.time.minute, 0)
                        );

                        print('Daily added ${Time(eatNotification.time.hour, eatNotification.time.minute, 0).toString()}'); //test display
                      } else {
                        //not daily notifiaction
                        DateTime ntfTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            eatNotification.time.hour, //hour
                            eatNotification.time.minute, //minute
                            0, //second
                            0, //milisec
                            0 //microsec
                        );

                        //if notification time is after today's hour,
                        //then move the notification to tomorrow
                        if(DateTime.now().isAfter(ntfTime)) {
                          ntfTime = ntfTime.add(Duration(days: 1));
                          print('Added');
                        }

                        //adding notification do the LocalNotifyManager
                        LocalNotifyManager.instance.showNotificationScheduled(
                            id: serialNumber,
                            title: 'Eating - ${DatabaseHelper.instance.animalName}',
                            body: eatNotification.infoText,
                            notificationDate: ntfTime
                        );
                      }

                      //increment serialNumber
                      await ntfSerialNumber.incrementCounter();

                      //test display  --start
                      List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll('NoticeEat');
                      print(queryRows);

                      print('databaseHelper: $i');
                      //test display --end


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
