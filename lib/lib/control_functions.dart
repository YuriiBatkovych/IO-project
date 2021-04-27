import 'package:animal_app/breed.dart';

bool verify_weight_data(dynamic weight)
{
  ///TO DO
/*
   if(weight.runtimeType == double || weight.runtimeType == int)
    {
      if(weight <= 0) return false;
      else return true;
    }
*/
  return false;
}


bool verify_animal_data(dynamic name, dynamic dataOfBirth, dynamic weight, dynamic breed)
{
  ///TO DO
   /*DateTime date;

   if(name.runtimeType != String) return false;
   if(dataOfBirth.runtimeType != String) return false;

   if(!verify_weight_data(weight)) return false;

   try{
     date = DateTime.parse(dataOfBirth);
   }
   catch(e){
      return false;
   }
*/
   return true;
}
