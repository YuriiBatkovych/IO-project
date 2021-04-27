// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:animal_app/notification.dart';

void main() {
  group('NotificationStatic', () {
    test('NoticeVet - remindTime should be a positive number', () {
      final nVet = NoticeVet();

      expect(nVet.remindTime, isPositive);
    });
    test('NoticeVet - date should be a date from the future', () {
      final nVet = NoticeVet();

      expect(nVet.date.isAfter(DateTime.now()), true);
    });
  });

  group('NotificationDynamic', () {
    test('NoticePlay - remindFrequency should be a positive number', () {
      final nPlay = NoticePlay();

      expect(nPlay.remindFrequency, isPositive);
    });
    test('NoticeEating - remindFrequency should be a positive number', () {
      final nEating = NoticeEating();

      expect(nEating.remindFrequency, isPositive);
    });
  });

}

