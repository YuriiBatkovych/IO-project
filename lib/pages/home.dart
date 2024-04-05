import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pet_app/pages/pet_profile/cards/pet_card_dog.dart';
import 'package:pet_app/pages/pet_profile/cards/pet_card_cat.dart';
import 'package:pet_app/database_helper.dart';
import 'package:pet_app/classes/animal.dart';


//notifications testing
import 'package:pet_app/localNotifyManager.dart';
import 'package:sqflite/sqflite.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List dogs = [];
  List cats = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDogsFromDB();
    getCatsFromDB();
    print('Initstate');
  }

  Future getDogsFromDB() async {
    print('getDogsFromDB - start');

    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll('Dog');
    print(queryRows);

    dogs = List.generate(queryRows.length, (i) {
      return Dog(
          id: queryRows[i]['id'],
          name: queryRows[i]['name'],
          dataOfBirth: DateTime.parse(queryRows[i]['dateOfBirth']),
          weight: queryRows[i]['weight'],
          profilImage: File(queryRows[i]['profileImage']),
          breed: queryRows[i]['breed']
      );
    });

    setState(() {
      isLoading = false;
    });
    print('getDogsFromDB -- end');
  }

  Future getCatsFromDB() async {
    print('getCatsFromDB - start');

    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll('Cat');
    print(queryRows);

    cats = List.generate(queryRows.length, (i) {
      return Cat(
          id: queryRows[i]['id'],
          name: queryRows[i]['name'],
          dataOfBirth: DateTime.parse(queryRows[i]['dateOfBirth']),
          weight: queryRows[i]['weight'],
          profilImage: File(queryRows[i]['profileImage']),
          breed: queryRows[i]['breed']
      );
    });

    setState(() {
      isLoading = false;
    });
    print('getCatsFromDB -- end');
  }

  Future deleteNotificationsFromDBAndLocalNtf(String table, String petType, int petId) async {
    // deleting the row from the DB
    DatabaseHelper.instance.delete(table, petId);

    // deleting notifications connected with the pet --start

    // firstly we have to get all pet notifications,
    // because we have to delete localNotifications
    // And then delete all notifications from DB and from localNotifications
    // from all three tables

    List<int> serialNumbers =[];

    // getting all notifications' serialNumber from this pet
    List<Map<String, dynamic>> rowsVet = await DatabaseHelper.instance.queryPetNotifications('NoticeVet', petType, petId);
    List.generate(rowsVet.length, (i) {
      serialNumbers.add(rowsVet[i]['serialNumber']);
    });

    List<Map<String, dynamic>> rowsEat = await DatabaseHelper.instance.queryPetNotifications('NoticeEat', petType, petId);
    List.generate(rowsEat.length, (i) {
      serialNumbers.add(rowsEat[i]['serialNumber']);
    });

    List<Map<String, dynamic>> rowsPlay = await DatabaseHelper.instance.queryPetNotifications('NoticePlay', petType, petId);
    List.generate(rowsPlay.length, (i) {
      serialNumbers.add(rowsPlay[i]['serialNumber']);
    });

    // we have all pet notifications' serialNumbers
    // so now we have to delete localNotifications
    for(int i = 0; i < serialNumbers.length; i++) {
      LocalNotifyManager.instance.cancelNotification(serialNumbers[i]);
      print('deleted notification serial number: ${serialNumbers[i]}');
    }

    print("serialNumbers.length: ${serialNumbers.length}");

    // and now just delete the rows from the database
    DatabaseHelper.instance.deleteNotifications('NoticeVet', petType, petId);
    DatabaseHelper.instance.deleteNotifications('NoticePlay', petType, petId);
    DatabaseHelper.instance.deleteNotifications('NoticeEat', petType, petId);


    // deleting notifications connected with the pet --end
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Your pets'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: isLoading ? CircularProgressIndicator() : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(   //dogs
                children: dogs.map((dog) => PetCardDog(
                    dog: dog,
                    delete: () async {
                      // actually not displaying  --start
                      await deleteNotificationsFromDBAndLocalNtf('Dog', 'Dog', dog.id);

                      // upadating the notifications list on the page
                      getDogsFromDB();
                      // actually not displaying  --end
                    },
                    viewProfile: (){
                    //  globals.petId = dog.id;
                      DatabaseHelper.instance.animalId = dog.id;
                      DatabaseHelper.instance.animal = 'Dog';
                      DatabaseHelper.instance.animalName = dog.name;

                      setState(() {
                        Navigator.pushNamed(
                            context, '/petPageDog'
                        );
                      });

                    },
                )).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(  //cats
                children: cats.map((cat) => PetCardCat(
                  cat: cat,
                  delete: () async {

                    // actually not displaying  --start
                    await deleteNotificationsFromDBAndLocalNtf('Cat', 'Cat', cat.id);

                    // upadating the pet list on the page
                    getCatsFromDB();
                    // --end
                  },
                  viewProfile: (){
                    DatabaseHelper.instance.animalId = cat.id;
                    DatabaseHelper.instance.animal = 'Cat';
                    DatabaseHelper.instance.animalName = cat.name;

                    setState(() {
                      Navigator.pushNamed(
                          context, '/petPageCat'
                      );
                    });
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(  //button to press if you enter all data and
        onPressed: () {
          setState(() {
            Navigator.pushNamed(
              context, '/addPetPage1',
            );
          });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        tooltip: 'Add pet',
      ),
    );
  }
}
