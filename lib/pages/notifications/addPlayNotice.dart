import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:pet_app/classes/notification.dart';

import 'package:pet_app/database_helper.dart';

import 'package:pet_app/sharedPreferences.dart' as ntfSerialNumber;
import 'package:pet_app/localNotifyManager.dart';

class addPlayNotice extends StatefulWidget {
  @override
  _addPlayNoticeState createState() => _addPlayNoticeState();
}

class _addPlayNoticeState extends State<addPlayNotice> {

  bool showTextInsteadOfDate = true; // true- show text; false-show date
  final NoticePlay playNotification = NoticePlay();

  // for choosing notificationTime
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    if (pickedTime != null)
      setState(() {
        playNotification.time = pickedTime;
        showTextInsteadOfDate = false;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Fun time'
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
                      ),
                      /// keyboardType: TextInputType.number,  // keyboard display numbers


                      onChanged: (val) {
                        setState(() {
                          playNotification.infoText = val;
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
                          value: playNotification.everyDay,
                          onChanged: (val){
                            setState(() {
                              playNotification.everyDay = val;
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
                              '${showTextInsteadOfDate ? 'choose time' : playNotification.time.format(context)}',
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
                      int i = await DatabaseHelper.instance.insert('NoticePlay', {
                        'infoText' : playNotification.infoText,
                        'time' : playNotification.time.format(context),
                        'everyDay' : (playNotification.everyDay ? 1 : 0),
                        'fromPetType' : DatabaseHelper.instance.animal,
                        'fromPetId' : DatabaseHelper.instance.animalId,
                        'serialNumber' : serialNumber
                      });

                      //adding notification do the LocalNotifyManager
                      if(playNotification.everyDay) {
                        //daily notification
                        LocalNotifyManager.instance.showNotificationDailyAtTime(
                            id: serialNumber,
                            title: 'Playing - ${DatabaseHelper.instance.animalName}',
                            body: playNotification.infoText,
                            notificationTime: Time(playNotification.time.hour, playNotification.time.minute, 0)
                        );
                      } else {
                        DateTime ntfTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            playNotification.time.hour, //hour
                            playNotification.time.minute, //minute
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
                            title: 'Playing - ${DatabaseHelper.instance.animalName}',
                            body: playNotification.infoText,
                            notificationDate: ntfTime
                        );
                      }

                      //incrementing serialNumber counter
                      await ntfSerialNumber.incrementCounter();

                      //test display  --start
                      List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll('NoticePlay');
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
