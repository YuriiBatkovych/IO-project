import 'package:pet_app/database_helper.dart';

class Breed {
  String breedType;

  Breed(String breedType)
  {
    this.breedType = breedType;
  }

  Future<String> calculateWeight(double weight, dynamic age) async
  {
    print('Age : '+ age.toString());
    List<Map<String, dynamic>> row =
    await DatabaseHelper.instance.queryWeight(breedType, age);
    print(row);

    double minWeight = row[0]['MinNormalWeight'];
    double maxWeight = row[0]['MaxNormalWeight'];

    if(weight<minWeight) return 'Underweight';
    if(weight>maxWeight) return 'Overweight';
    else return 'Normal';
  }

}