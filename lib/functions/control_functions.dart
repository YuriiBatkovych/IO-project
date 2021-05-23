
bool verify_weight_data(dynamic weight)
{
  if(weight == null || weight=='') return false;
  double trueData;
  try{
    trueData = double.parse(weight);
  }
  catch(e){
    return false;
  }
  if(trueData<=0 || trueData>=200) return false;
  return true;
}

bool verify_dateofBirth_data(dynamic dateOfBirth)
{
  if(dateOfBirth == null || dateOfBirth.runtimeType!=DateTime) return false;
  return true;
}

bool verify_name_data(dynamic name)
{
  if(name==null || name.runtimeType!=String) return false;
  if(name == '') return false;
  return true;
}


bool verify_animal_data(dynamic name, dynamic dateOfBirth, dynamic weight, dynamic breed)
{

   if(!verify_name_data(name)) return false;

   if(breed==null || breed.runtimeType != String) return false;

   if(!verify_dateofBirth_data(dateOfBirth)) return false;
   if(!verify_weight_data(weight)) return false;
   return true;
}
