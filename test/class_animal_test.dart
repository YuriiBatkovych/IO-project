import 'package:test/test.dart';
import 'dart:io';
import 'package:pet_app/classes/animal.dart';

void main() async{

  File justfortest;
  DateTime dateOfBirth = DateTime.tryParse('2016-03-12');

  group('Animal change weight', () {

    Dog a = Dog(id: 1, name: 'Donald', dataOfBirth: dateOfBirth, weight: 23, profilImage: justfortest, breed: 'German Shepherd');
    test('change_weight(-1)', () {
      var actualWeight = a.getWeight();
      a.change_weight(-1);
      expect(a.getWeight(), actualWeight);
    });

    test('change_weight(0)', () {
      var actualWeight = a.getWeight();
      a.change_weight(0);
      expect(a.getWeight(), actualWeight);
    });

    test('change_weight(-3.4)', () {
      var actualWeight = a.getWeight();
      a.change_weight(-3.4);
      expect(a.getWeight(), actualWeight);
    });

    test('change_weight(16)', () {
      a.change_weight(16);
      expect(a.getWeight(), 16);
    });

    test('change_weight(11.78)', () {
      a.change_weight(11.78);
      expect(a.getWeight(), 11.78);
    });

    test('change_weight(String)', () {
      var actualWeight = a.getWeight();
      a.change_weight('Hryszko');
      expect(a.getWeight(), actualWeight);
    });

    test('change_weight(null)', () {
      var actualWeight = a.getWeight();
      a.change_weight(null);
      expect(a.getWeight(), actualWeight);
    });
  });
}