import 'package:flutter/material.dart';

class Notification {                                     ///design pattern COMMAND
  String infoText;                                       ///turns the request into a standalone object containing
  int id;                                                ///all the information about the notification
  int serialNumber;

  Notification.named(int tempId, String tempText, int serialNumber) {
    this.infoText = tempText;
    this.id = tempId;
    this.serialNumber = serialNumber;
  }

  void cancel(){}
}


class NotificationStatic extends Notification {
  DateTime date;
  int remindTime;

  NotificationStatic.named(int tempId, String tempText, DateTime tempDate, int tempremind, int serialNumber) : super.named(tempId, tempText, serialNumber){
    this.date = tempDate;
    this.remindTime = tempremind;
  }

  void changeDate(){}
}

class NotificationDynamic extends Notification {
  TimeOfDay time;
  bool everyDay;

  NotificationDynamic.named(int id, String infoText, TimeOfDay time, bool everyDay, int serialNumber) : super.named(id, infoText, serialNumber) {
    this.time = time;
    this.everyDay = everyDay;
  }


  void changeFrequency(){}
}


class NoticeVet extends NotificationStatic {
  bool vaccination;

  NoticeVet() : super.named(0, '', DateTime.now(), 7, 0) {this.vaccination = false;}
  NoticeVet.named({int tempId, String text, DateTime tempDate, int remind, bool vacc, int serialNumber}) : super.named(tempId, text, tempDate, remind, serialNumber){
    this.vaccination = vacc;
  }

  void setValues(String text, bool vacc, DateTime tempDate, int remind) {
    this.infoText = text;
    this.vaccination = vacc;
    this.date = tempDate;
    this.remindTime = remind;
  }
}

class NoticePlay extends NotificationDynamic {
  NoticePlay() : super.named(0, '', null, false, 0);
  NoticePlay.named({int id, String infoText, TimeOfDay time, bool everyDay, int serialNumber}) : super.named(id, infoText, time, everyDay, serialNumber);
}

class NoticeEat extends NotificationDynamic {
  NoticeEat() : super.named(0, '', null, false, 0);
  NoticeEat.named({int id, String infoText, TimeOfDay time, bool everyDay, int serialNumber}) : super.named(id, infoText, time, everyDay, serialNumber);
}