import 'dart:io';
import 'package:animal_app/breed.dart';

class Animal
{
   String _name;
   DateTime _dateOfBirth;
   dynamic weight;
   File _profilImage;
   Breed _breed;


   Animal(String name, String dataOfBirth, dynamic weight, File profilImage, Breed breed)
   {
     this._name = name;
     this._dateOfBirth = DateTime.parse(dataOfBirth);
     this._profilImage= profilImage;
     this.weight= weight;
     this._breed = breed;
   }

   void change_profil_image(File newImage)
   {
      /// To DO
   }

   void change_weight(dynamic newWeight)
   {
     /// TO DO
      /*if(verify_weight_data(newWeight))
        {
          this.weight = newWeight;
        }
      */
   }

   String check_weight()
   {
     ///To DO
      return 'Normal';
   }

   String getName() { return _name; }
   dynamic getWeight() { return weight;}
   DateTime getDateOfBirth() { return _dateOfBirth;}


}

class Dog extends Animal
{
  Dog(String name, String dataOfBirth, dynamic weight, File profilImage, Breed breed) :
        super(name, dataOfBirth, weight, profilImage, breed);

  ///TO DO

}

class Cat extends Animal
{
  Cat(String name, String dataOfBirth, dynamic weight, File profilImage, Breed breed) :
        super(name, dataOfBirth, weight, profilImage, breed);


  ///TO DO
}

