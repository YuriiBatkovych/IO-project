import 'dart:io';
import 'package:pet_app/classes/breed.dart';
import 'package:pet_app/functions/control_functions.dart' as ctrlF;

class Animal
{
   int id;
   String name;
   DateTime dateOfBirth;
   dynamic weight;
   File profilImage;
   String breed;


   Animal(int id, String name, DateTime dataOfBirth, dynamic weight, File profilImage, String breed)
   {
     this.id = id;
     this.name = name;
     this.dateOfBirth = dataOfBirth;
     this.profilImage= profilImage;
     this.weight= weight;
     this.breed = breed;
   }

   void change_weight(dynamic newWeight)
   {
     if(ctrlF.verify_weight_data(newWeight.toString()))
       weight = newWeight;
   }


   ///if age is >= 1 year print years + months
   ///if age is < 1 year and months >1 ,  print months + days
   ///if age is < 1 and months < 1 , print days
   ///else print hours

   String calculateAge()
   {
     DateTime currentDate = DateTime.now();
     int yearDifference = currentDate.year - dateOfBirth.year;
     int age = yearDifference;
     int month1 = currentDate.month;
     int month2 = dateOfBirth.month;

     int monthDifferense = month1-month2;

     int day1 = currentDate.day;
     int day2 = dateOfBirth.day;

     int dayDifferense = day1 - day2;

     if (month2 > month1) {
       age--;
     } else if (month1 == month2) {
       if (day2 > day1) {
         age--;
       }
     }

     if(monthDifferense<0) monthDifferense = 12+monthDifferense;
     else if(monthDifferense==0 && yearDifference==1) monthDifferense=11;
     if(dayDifferense<0) dayDifferense = 30+dayDifferense;

     if(age != 0) {
       return '$age years $monthDifferense months';
     }
     if(monthDifferense != 0){
       return '$monthDifferense months $dayDifferense days';
     }
     if(dayDifferense != 0) {
       return '$dayDifferense days';
     }
     return '${currentDate.hour} hours';

   }


   String getName() { return name; }
   dynamic getWeight() { return weight;}
   DateTime getDateOfBirth() { return dateOfBirth;}
   File getImage() {return profilImage ;}


}

class Dog extends Animal
{
  Dog({int id, String name, DateTime dataOfBirth, dynamic weight, File profilImage, String breed}) :
        super(id, name, dataOfBirth, weight, profilImage, breed);

  dynamic calculateAgeForChekingWeight()
  {
    DateTime currentDate = DateTime.now();
    dynamic age = currentDate.year - dateOfBirth.year;

    int yearDifference = currentDate.year - dateOfBirth.year;

    int month1 = currentDate.month;
    int month2 = dateOfBirth.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dateOfBirth.day;
      if (day2 > day1) {
        age--;
      }
    }

    int monthDifferense = month1 - month2;
    if(monthDifferense<0) monthDifferense = 12+monthDifferense;
    else if(monthDifferense==0 && yearDifference==1) monthDifferense=11;

    if(age>=2) age=2;
    else if(age<1) {
      if (monthDifferense>=5) {
        age = 0.5;
      }
      else {
        age = 0.25;
      }
    }
    return age;
  }

  Future<String> check_weight() async {
    dynamic age = calculateAgeForChekingWeight();
    Breed breedName = Breed(breed);
    return breedName.calculateWeight(weight, age);
  }

}

class Cat extends Animal
{
  Cat({int id, String name, DateTime dataOfBirth, dynamic weight, File profilImage, String breed}) :
        super(id, name, dataOfBirth, weight, profilImage, breed);

  dynamic calculateAgeForChekingWeight()
  {
    DateTime currentDate = DateTime.now();
    dynamic age = currentDate.year - dateOfBirth.year;

    int yearDifference = currentDate.year - dateOfBirth.year;

    int month1 = currentDate.month;
    int month2 = dateOfBirth.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dateOfBirth.day;
      if (day2 > day1) {
        age--;
      }
    }

    int monthDifferense = month1 - month2;
    if(monthDifferense<0) monthDifferense = 12+monthDifferense;
    else if(monthDifferense==0 && yearDifference==1) monthDifferense=11;

    if(age>=1) age=1;
    else if(age<1) {
      if (monthDifferense>=6) {
        age = 0.5;
      }
      else if(monthDifferense>=3){
        age = 0.25;
      }
      else age = 0.08;
    }
    return age;
  }

  Future<String> check_weight() async {
    dynamic age = calculateAgeForChekingWeight();
    Breed breedName = Breed(breed);
    return breedName.calculateWeight(weight, age);
  }
}

