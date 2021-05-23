import 'package:flutter/material.dart';
import 'package:pet_app/classes/notification.dart';
import 'package:pet_app/pages/notifications/cards/notification_card_vet.dart';
import 'package:pet_app/database_helper.dart';
import 'package:pet_app/pages/notifications/cards/notification_card_play.dart';
import 'package:pet_app/pages/notifications/cards/notification_card_eat.dart';

import 'package:pet_app/localNotifyManager.dart';
import 'package:intl/intl.dart'; //for dateformat


class notificationPage extends StatefulWidget {
  @override
  _notificationPageState createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {

  List notificationsVet = [];
  List notificationsPlay = [];
  List notificationsEat = [];

  bool isLoading;

  TimeOfDay stringToTimeOfDay(String time) {
    print('Time: |$time|, length: ${time.length}');
    if(time.length <= 5) {
      // format 24hours
      return TimeOfDay(hour: int.parse(time.split(":")[0]),
          minute: int.parse(time.split(":")[1]));
    }
    else {
      //format 12hours
      final format = DateFormat.jm(); //"6:00 AM"
      return TimeOfDay.fromDateTime(format.parse(time));
    }
  }

  @override
  void initState() {
    super.initState();
    getNotificationsVetFromDB();
    getNotificationsPlayFromDB();
    getNotificationsEatFromDB();
    print('Initstate');  //test display
  }

  Future getNotificationsVetFromDB() async {
    print('getNotificationsVetFromDB - start');

    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryPetNotifications('NoticeVet', DatabaseHelper.instance.animal, DatabaseHelper.instance.animalId);
    print(queryRows);

    notificationsVet = List.generate(queryRows.length, (i) {
      return NoticeVet.named(
          tempId: queryRows[i]['id'],
          text: queryRows[i]['infoText'],
          tempDate: DateTime.parse(queryRows[i]['appointmentDate']),
          vacc: (queryRows[i]['vaccination'] == 1 ? true : false),
          remind: queryRows[i]['remindTime'],
          serialNumber: queryRows[i]['serialNumber']
      );
    });

    setState(() {
      isLoading = false;
    });
    print('getNotificationsVetFromDB -- end');
  }

  Future getNotificationsPlayFromDB() async {
    print('getNotificationsPlayFromDB - start');

    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryPetNotifications('NoticePlay', DatabaseHelper.instance.animal, DatabaseHelper.instance.animalId);
    print(queryRows);

    notificationsPlay = List.generate(queryRows.length, (i) {
      return NoticePlay.named(
          id: queryRows[i]['id'],
          infoText: queryRows[i]['infoText'],
          time: stringToTimeOfDay(queryRows[i]['time']),
          everyDay: (queryRows[i]['everyDay'] == 1 ? true : false),
          serialNumber: queryRows[i]['serialNumber']
      );
    });

    setState(() {
      isLoading = false;
    });
    print('getNotificationsPlayFromDB -- end');
  }

  Future getNotificationsEatFromDB() async {
    print('getNotificationsEatFromDB - start');

    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryPetNotifications('NoticeEat', DatabaseHelper.instance.animal, DatabaseHelper.instance.animalId);
    print(queryRows);

    notificationsEat = List.generate(queryRows.length, (i) {
      return NoticeEat.named(
          id: queryRows[i]['id'],
          infoText: queryRows[i]['infoText'],
          time: stringToTimeOfDay(queryRows[i]['time']),
          everyDay: (queryRows[i]['everyDay'] == 1 ? true : false),
          serialNumber: queryRows[i]['serialNumber']
      );
    });

    setState(() {
      isLoading = false;
    });
    print('getNotificationsEatFromDB -- end');
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications'
        ),
        centerTitle: true,
      ),
      body: Container(
        child: isLoading ? CircularProgressIndicator() : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3.0,
                    primary: Colors.redAccent,
                  ),
                  onPressed: () async{
                    setState(() {
                      Navigator.pushNamed(
                          context, '/chooseNotification',
                      );
                    });
                  },
                  child: Text(
                    'Add notification',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: notificationsVet.map((notice) => NotificationCardVet(
                  vetNtf: notice,
                  delete: () async {
                    // deleting the row from the DB
                    DatabaseHelper.instance.delete('NoticeVet', notice.id);

                    //deleting notification from localNotifications
                    LocalNotifyManager.instance.cancelNotification(notice.serialNumber);

                    // upadating the notifications list on the page
                    getNotificationsVetFromDB();
                  }
              )).toList(),
            ),
            Column(
              children: notificationsPlay.map((notice) => NotificationCardPlay(
                  playNtf: notice,
                  delete: () async {
                    // deleting the row from the DB
                    DatabaseHelper.instance.delete('NoticePlay', notice.id);

                    //deleting notification from localNotifications
                    LocalNotifyManager.instance.cancelNotification(notice.serialNumber);

                    // upadating the notifications list on the page
                    getNotificationsPlayFromDB();
                  }
              )).toList(),
            ),
            Column(
              children: notificationsEat.map((notice) => NotificationCardEat(
                  eatNtf: notice,
                  delete: () async {
                    // deleting the row from the DB
                    DatabaseHelper.instance.delete('NoticeEat', notice.id);

                    //deleting notification from localNotifications
                    LocalNotifyManager.instance.cancelNotification(notice.serialNumber);

                    // upadating the notifications list on the page
                    getNotificationsEatFromDB();
                  }
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
