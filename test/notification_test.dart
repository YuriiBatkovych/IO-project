import 'package:test/test.dart';
import 'package:pet_app/classes/notification.dart';
import 'dart:io';

void main() {
  group('NotificationStatic', () {
    test('NoticeVet - remindTime should be a positive number', () {
      final nVet = NoticeVet();

      expect(nVet.remindTime, isPositive);
    });
    test('NoticeVet - date should be a date from the future or now', () {
      DateTime now = DateTime.now();
      final nVet = NoticeVet();

      expect(nVet.date.isAfter(now) || nVet.date.isAtSameMomentAs(now), true);
    });
  });

  group('NotificationDynamic', () {
    test('NoticePlay - id should be a nonnegative number', () {
      final nPlay = NoticePlay();

      expect(nPlay.id, isNonNegative);
    });
    test('NoticeEating - id should be a nonnegative number', () {
      final nEating = NoticeEat();

      expect(nEating.id, isNonNegative);
    });
  });
}