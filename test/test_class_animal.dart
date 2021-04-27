import 'package:test/test.dart';
import 'dart:io';
import 'package:animal_app/animal.dart';
import 'package:animal_app/breed.dart';

void main() {
  File justfortest;

  group('Animal change weight', () {
    Animal a = Animal('donald', '2016-03-12', 23, justfortest, germanShepherd);
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

    test('change_weight(String)', () {
      var actualWeight = a.getWeight();
      a.change_weight(null);
      expect(a.getWeight(), actualWeight);
    });
  });

  group('Animal check weight', () {
    Animal a = Animal('donald', '2016-03-12', 0.3, justfortest, germanShepherd);
    test('check weight old one : 0.3', () {
      expect(a.check_weight(), equals('Underweight'));
    });

    test('check weight old one : 200', () {
      a.weight = 200;
      expect(a.check_weight(), equals('Overweight'));
    });

    test('check weight old one : 1500', () {
      a.weight = 1500;
      expect(a.check_weight(), equals('Overweight'));
    });

    test('check weight old one : 0.00001', () {
      a.weight = 0.00001;
      expect(a.check_weight(), equals('Underweight'));
    });

    test('check weight old one : 25', () {
      a.weight = 25;
      expect(a.check_weight(), equals('Normal'));
    });

    Animal b = Animal('donald', '2021-03-12', 0.3, justfortest, germanShepherd);

    test('check weight young one : 3', () {
      expect(a.check_weight(), equals('Normal'));
    });

    test('check weight young one : 10', () {
      a.weight = 10;
      expect(a.check_weight(), equals('Overweight'));
    });

    test('check weight young one : 1500', () {
      a.weight = 1500;
      expect(a.check_weight(), equals('Overweight'));
    });

    test('check weight young one : 0.1', () {
      a.weight = 0.1;
      expect(a.check_weight(), equals('Underweight'));
    });

    test('check weight young one : 25', () {
      a.weight = 25;
      expect(a.check_weight(), equals('Overweight'));
    });
  });

  group('CheckWeight - adult dog male', () {
    final tempAnimal = Dog('',"2016-07-22", 40, justfortest, germanShepherd);
    test('Dog - checkWeight 1', () {
      expect(tempAnimal.check_weight(), equals("Normal"));
    });
    test('Dog - checkWeight 2', () {
      tempAnimal.weight = 60;
      expect(tempAnimal.check_weight(), equals("Overweight"));
    });
    test('Dog - checkWeight 3', () {
      tempAnimal.weight = 20;
      expect(tempAnimal.check_weight(), equals("Underweight"));
    });
  });


  group('CheckWeight - young dog male', () {
    final tempAnimal = Dog('',"2021-01-22", 25, justfortest, germanShepherd);

    test('Dog - checkWeight 1', () {
      expect(tempAnimal.check_weight(), equals("Normal"));
    });
    test('Dog - checkWeight 2', () {
      tempAnimal.weight = 49;
      expect(tempAnimal.check_weight(), equals("Overweight"));
    });
    test('Dog - checkWeight 3', () {
      tempAnimal.weight = 5;
      expect(tempAnimal.check_weight(), equals("Underweight"));
    });
  });

  group('CheckWeight - adult cat', () {
    final tempAnimal = Cat('',"2016-07-22", 7, justfortest, britishCat);
    test('Cat - checkWeight 1', () {
      expect(tempAnimal.check_weight(), equals("Normal"));
    });
    test('Cat - checkWeight 2', () {
      tempAnimal.weight = 2;
      expect(tempAnimal.check_weight(), equals("UnderWeight"));
    });
    test('Cat - checkWeight 3', () {
      tempAnimal.weight = 12;
      expect(tempAnimal.check_weight(), equals("Overweight"));
    });
  });
  group('CheckWeight - young cat', () {
    final tempAnimal = Cat('',"2021-01-22", 4, justfortest, britishCat);
    test('Cat - checkWeight 1', () {
      expect(tempAnimal.check_weight(), equals("Normal"));
    });
    test('Cat - checkWeight 2', () {
      tempAnimal.weight = 9;
      expect(tempAnimal.check_weight(), equals("Overweight"));
    });
    test('Cat - checkWeight 3', () {
      tempAnimal.weight = 22;
      expect(tempAnimal.check_weight(), equals("Underweight"));
    });
  });
}