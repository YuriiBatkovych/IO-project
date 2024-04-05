import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'sharedPreferences.dart';  // for incrementing serialNumber of notification

class DatabaseHelper {

  static final _dbName = 'petDatabase.db';
  static final _dbVersion = 1;

  // for "sessions"
  String animal;
  int animalId;

  String animalName; //only for displaying name in local notification
  //


  /// making it a singleton class                         design pattern Singleton
  DatabaseHelper._privateConstructor();                  /// We need only one DataBase
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase () async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    // creating notification tables --start
    db.execute(
      '''
      CREATE TABLE NoticeVet (
      id INTEGER PRIMARY KEY,
      infoText TEXT,
      remindTime INTEGER,
      appointmentDate TEXT,
      vaccination INTEGER,
      fromPetType TEXT,
      fromPetId INTEGER,
      serialNumber INTEGER
      )
      '''
    );
    db.execute(
        '''
      CREATE TABLE NoticePlay (
      id INTEGER PRIMARY KEY,
      infoText TEXT,
      time TEXT,
      everyDay INTEGER,
      fromPetType TEXT,
      fromPetId INTEGER,
      serialNumber INTEGER
      )
      '''
    );
    db.execute(
        '''
      CREATE TABLE NoticeEat (
      id INTEGER PRIMARY KEY,
      infoText TEXT,
      time TEXT,
      everyDay INTEGER,
      fromPetType TEXT,
      fromPetId INTEGER,
      serialNumber INTEGER
      )
      '''
    );
    // creating notification tables --end


    // creating dog and cat tables --start
    db.execute(
        '''
      CREATE TABLE Dog (
      id INTEGER PRIMARY KEY,
      name TEXT,
      dateOfBirth TEXT,
      weight REAL,
      profileImage TEXT,
      breed TEXT
      )
      '''
    );

    db.execute(
        '''
      CREATE TABLE Cat (
      id INTEGER PRIMARY KEY,
      name TEXT,
      dateOfBirth TEXT,
      weight REAL,
      profileImage TEXT,
      breed TEXT
      )
      '''
    );
    // creating dog and cat tables --end

    //http://www.puppychart.com/

    //tutorial
    // https://www.youtube.com/watch?v=8bV9ixYNAL4&ab_channel=TheGrowingDeveloper
    db.execute(
        '''
      CREATE TABLE Breed (
      BreedName TEXT,
      age REAL,
      MinNormalWeight REAL,
      MaxNormalWeight REAL,
      PRIMARY KEY (BreedName, age)
      )
      '''
    );

    //INSERTING DOG'S WEIGHT DATA :

    //inserting Labrador's information

    db.insert('Breed', {
      'BreedName': 'Labrador',
      'age': 0.25,
      'MinNormalWeight': 10,
      'MaxNormalWeight': 15
    });

    db.insert('Breed', {
      'BreedName': 'Labrador',
      'age': 0.5,
      'MinNormalWeight': 22,
      'MaxNormalWeight': 30
    });

    db.insert('Breed', {
      'BreedName': 'Labrador',
      'age': 1,
      'MinNormalWeight': 27,
      'MaxNormalWeight': 37
    });

    db.insert('Breed', {
      'BreedName': 'Labrador',
      'age': 2,
      'MinNormalWeight': 27,
      'MaxNormalWeight': 40
    });

    //inserting German Shepherd's information

    db.insert('Breed', {
      'BreedName': 'German Shepherd',
      'age': 0.25,
      'MinNormalWeight': 12,
      'MaxNormalWeight': 14
    });

    db.insert('Breed', {
      'BreedName': 'German Shepherd',
      'age': 0.5,
      'MinNormalWeight': 24,
      'MaxNormalWeight': 30
    });

    db.insert('Breed', {
      'BreedName': 'German Shepherd',
      'age': 1,
      'MinNormalWeight': 29,
      'MaxNormalWeight': 38
    });

    db.insert('Breed', {
      'BreedName': 'German Shepherd',
      'age': 2,
      'MinNormalWeight': 30,
      'MaxNormalWeight': 40
    });

    //inserting Akita's values

    db.insert('Breed', {
      'BreedName': 'Akita',
      'age': 0.25,
      'MinNormalWeight': 15,
      'MaxNormalWeight': 18
    });

    db.insert('Breed', {
      'BreedName': 'Akita',
      'age': 0.5,
      'MinNormalWeight': 33,
      'MaxNormalWeight': 40
    });

    db.insert('Breed', {
      'BreedName': 'Akita',
      'age': 1,
      'MinNormalWeight': 44,
      'MaxNormalWeight': 56
    });

    db.insert('Breed', {
      'BreedName': 'Akita',
      'age': 2,
      'MinNormalWeight': 45,
      'MaxNormalWeight': 60
    });

    //inserting Pekingese's values

    db.insert('Breed', {
      'BreedName': 'Pekingese',
      'age': 0.25,
      'MinNormalWeight': 1.7,
      'MaxNormalWeight': 3.3
    });

    db.insert('Breed', {
      'BreedName': 'Pekingese',
      'age': 0.5,
      'MinNormalWeight': 2.7,
      'MaxNormalWeight': 5.5
    });

    db.insert('Breed', {
      'BreedName': 'Pekingese',
      'age': 1,
      'MinNormalWeight': 3.3,
      'MaxNormalWeight': 6.4
    });

    db.insert('Breed', {
      'BreedName': 'Pekingese',
      'age': 2,
      'MinNormalWeight': 3.2,
      'MaxNormalWeight': 6.5
    });

    //END OF INSERING DOG'S WEIGHT DATA

    //INSERTING CAT'S DATA
    //inserting British Shorthair's information

    db.insert('Breed', {
      'BreedName': 'British Shorthair',
      'age': 0.08,
      'MinNormalWeight': 0.250,
      'MaxNormalWeight': 0.740
    });

    db.insert('Breed', {
      'BreedName': 'British Shorthair',
      'age': 0.25,
      'MinNormalWeight': 1,
      'MaxNormalWeight': 2.5
    });

    db.insert('Breed', {
      'BreedName': 'British Shorthair',
      'age': 0.5,
      'MinNormalWeight': 2.3,
      'MaxNormalWeight': 5.4
    });

    db.insert('Breed', {
      'BreedName': 'British Shorthair',
      'age': 1,
      'MinNormalWeight': 2.5,
      'MaxNormalWeight': 8.0
    });

    //inserting Scottish Fold's information
    db.insert('Breed', {
      'BreedName': 'Scottish Fold',
      'age': 0.08,
      'MinNormalWeight': 0.250,
      'MaxNormalWeight': 0.740
    });

    db.insert('Breed', {
      'BreedName': 'Scottish Fold',
      'age': 0.25,
      'MinNormalWeight': 1,
      'MaxNormalWeight': 2.5
    });

    db.insert('Breed', {
      'BreedName': 'Scottish Fold',
      'age': 0.5,
      'MinNormalWeight': 2.3,
      'MaxNormalWeight': 5.4
    });

    db.insert('Breed', {
      'BreedName': 'Scottish Fold',
      'age': 1,
      'MinNormalWeight': 2.5,
      'MaxNormalWeight': 8.0
    });

    //inserting Maine Coon's information
    db.insert('Breed', {
      'BreedName': 'Maine Coon',
      'age': 0.08,
      'MinNormalWeight': 0.560,
      'MaxNormalWeight': 0.750
    });

    db.insert('Breed', {
      'BreedName': 'Maine Coon',
      'age': 0.25,
      'MinNormalWeight': 1.7,
      'MaxNormalWeight': 2.3
    });

    db.insert('Breed', {
      'BreedName': 'Maine Coon',
      'age': 0.5,
      'MinNormalWeight': 3.2,
      'MaxNormalWeight': 6
    });

    db.insert('Breed', {
      'BreedName': 'Maine Coon',
      'age': 1,
      'MinNormalWeight': 4.5,
      'MaxNormalWeight': 10.0
    });

    //inserting Kurilian bobtail's information
    db.insert('Breed', {
      'BreedName': 'Kurilian bobtail',
      'age': 0.08,
      'MinNormalWeight': 0.4,
      'MaxNormalWeight': 0.8
    });

    db.insert('Breed', {
      'BreedName': 'Kurilian bobtail',
      'age': 0.25,
      'MinNormalWeight': 1.7,
      'MaxNormalWeight': 3
    });

    db.insert('Breed', {
      'BreedName': 'Kurilian bobtail',
      'age': 0.5,
      'MinNormalWeight': 2.9,
      'MaxNormalWeight': 4.5
    });

    db.insert('Breed', {
      'BreedName': 'Kurilian bobtail',
      'age': 1,
      'MinNormalWeight': 3.5,
      'MaxNormalWeight': 5.5
    });

  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('$table', row);
  }

  Future<List<Map<String,dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    return await db.query('$table');
  }

  Future<List<Map<String,dynamic>>> queryOne(String table, int id) async {
    Database db = await instance.database;
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String,dynamic>>> queryPetNotifications(String table, String petType, int id) async {
    Database db = await instance.database;
    return await db.query(table, where: 'fromPetType = ? AND fromPetId = ?', whereArgs: [petType, id]);
  }

  Future updatePetPhoto(String petType, int petId, String newPhotoPath) async {
    Database db = await instance.database;
    db.execute(
        '''
      UPDATE $petType
      SET profileImage = '$newPhotoPath'
      WHERE
      id = $petId
      '''
    );
    print('Photo updated succesfully');
  }

  Future<List<Map<String,dynamic>>> queryWeight(String breed, dynamic age) async {
    Database db = await instance.database;
    return await db.query('Breed', where: 'BreedName = ? AND age = ?', whereArgs: [breed, age]);
  }

  Future<int> updateWeight (String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('$table', row, where: 'id = ?', whereArgs: [id]);
  }

  /*Future update (Map<String, dynamic> row) async {
    Database db = await instance.database;
    //db.update('NoticeVet', row, where: 'remindTime = ?');
  }*/

  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete('$table', where: 'id = ?', whereArgs: [id]);
  }


  Future<int> deleteNotifications(String table, String petType, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'fromPetType = ? AND fromPetId = ?', whereArgs: [petType, id]);
  }




}