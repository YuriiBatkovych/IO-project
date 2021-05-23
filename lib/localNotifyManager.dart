
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class LocalNotifyManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static final LocalNotifyManager instance = LocalNotifyManager.init();

  LocalNotifyManager.init() {
    if(flutterLocalNotificationsPlugin == null) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      var settingAndroid = AndroidInitializationSettings("app_icon");
      var initializationsSettings = InitializationSettings(
          android: settingAndroid);
      flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    }
  }

  Future showNotificationScheduled({@required int id, @required String title, @required String body, @required DateTime notificationDate}) async {
    var androidDetails = AndroidNotificationDetails("Channel ID", "Channel Name", "Channel Description",
        importance: Importance.max,
        //subText: 'Bla bla bla',
        enableLights: true,
        enableVibration: false,
        color: Colors.blue,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500
      // priority: Priority.high,
      // showWhen: false
    );
    var generalNotificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, notificationDate, generalNotificationDetails);
  }

  Future showNotificationDailyAtTime ({@required int id, @required String title, @required String body, @required Time notificationTime}) async {
    var androidDetails = AndroidNotificationDetails("Channel ID", "Channel Name", "Channel Description",
        importance: Importance.max,
        //subText: 'Bla bla bla',
        enableLights: true,
        enableVibration: false,
        color: Colors.blue,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500
      // priority: Priority.high,
      // showWhen: false
    );

    var generalNotificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, notificationTime, generalNotificationDetails);
  }

  Future showNotificationt() async {
    var androidDetails = AndroidNotificationDetails("Channel ID", "Channel Name", "Channel Description",
        importance: Importance.max
      // priority: Priority.high,
      // showWhen: false
    );

    var generalNotificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(0, "Task", "You created a Task", generalNotificationDetails, payload: "Welcome to pet app");
  }

  Future cancelNotification(int serialNumber) async {
    await flutterLocalNotificationsPlugin.cancel(serialNumber);
  }

  Future displayNotificationsAll() async {
  }



}
