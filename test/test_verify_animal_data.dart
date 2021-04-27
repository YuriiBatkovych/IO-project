import 'package:test/test.dart';
import 'package:animal_app/control_functions.dart';
import 'package:animal_app/breed.dart';

void main()
{
    group("Name" , (){
      test("Int instead of name", () {
        var result = verify_animal_data(34, "2021-07-19", 16, germanShepherd);
        expect(result, false);
      });

      test("Double instead of name", () {
        var result = verify_animal_data(34.999, "2021-07-19", 16, germanShepherd);
        expect(result, false);
      });

      test("List instead of name", () {
        var result = verify_animal_data([3, 7, 7], "2021-07-19", 16, germanShepherd);
        expect(result, false);
      });

      test("Long name", () {
        var result = verify_animal_data("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU", "2021-07-19", 16, germanShepherd);
        expect(result, true);
      });

      test("Empty name", () {
        var result = verify_animal_data('', "2021-07-19", 16, germanShepherd);
        expect(result, false);
      });
    });

    group("Weight" , (){
      test("Int weight", () {
        var result = verify_animal_data("Olver", "2021-07-19", 16, germanShepherd);
        expect(result, true);
      });

      test("Double weight", () {
        var result = verify_animal_data("Olver", "2021-07-19", 16.9, germanShepherd);
        expect(result, true);
      });

      test("String instead of weight", () {
        var result = verify_animal_data("Olver", "2021-07-19", "6748", germanShepherd);
        expect(result, false);
      });

      test("Minus weight", () {
        var result = verify_animal_data("Olver", "2021-07-19", -16, germanShepherd);
        expect(result, false);
      });

      test("Zero weight", () {
        var result = verify_animal_data("Olver", "2021-07-19", 0, germanShepherd);
        expect(result, false);
      });
    });

    group("Date of birth" , (){
      test("Ok format 1", () {
        var result = verify_animal_data("Olver", "2021-07-19", 16, germanShepherd);
        expect(result, true);
      });

      test("Ok format 2", () {
        var result = verify_animal_data("Olver", "20210719", 16, germanShepherd);
        expect(result, true);
      });

      test("Ok format 3", () {
        var result = verify_animal_data("Olver", "+20210719", 16, germanShepherd);
        expect(result, true);
      });

      test("no ok format", () {
        var result = verify_animal_data("Olver", "12-07-2021", 16, germanShepherd);
        expect(result, false);
      });

      test("not date", () {
        var result = verify_animal_data("Olver", "erikernk", 16, germanShepherd);
        expect(result, false);
      });

      test("Int- not date", () {
        var result = verify_animal_data("Olver", 56, 16, germanShepherd);
        expect(result, false);
      });

      test("Double- not date", () {
        var result = verify_animal_data("Olver", 56, 16, germanShepherd);
        expect(result, false);
      });
    });

    group("Combined" , (){
      test("Int instead of name and date", () {
        var result = verify_animal_data(56, 347555, 16, germanShepherd);
        expect(result, false);
      });

      test("OK", () {
        var result = verify_animal_data("Olver", "2021-07-19", 16, germanShepherd);
        expect(result, true);
      });

      test("Double instead of all", () {
        var result = verify_animal_data(45.99, 67, -16, germanShepherd);
        expect(result, false);
      });

      test("List instead of  wage", () {
        var result = verify_animal_data("Olver", [67, 56, 89], 16, germanShepherd);
        expect(result, false);
      });

      test("String all", () {
        var result = verify_animal_data("Olver", "2021-07-19", "78", germanShepherd);
        expect(result, false);
      });
    });
}