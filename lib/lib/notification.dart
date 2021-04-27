

class Notification {
  String infoText;

  void cancel(){}
}


class NotificationStatic extends Notification {
  DateTime date;
  int remindTime = 1;

  void changeDate(){}
}

class NotificationDynamic extends Notification {
  int remindFrequency = 2;
  bool continuous;

  void changeFrequency(){}
}


class NoticeVet extends NotificationStatic {
  bool vaccination;
  String infoText = "Vet notification";
}

class NoticePlay extends NotificationDynamic {
  String infoText = "Playing time notification";
}

class NoticeEating extends NotificationDynamic {
  String infoTest = "Eating time notification";
}