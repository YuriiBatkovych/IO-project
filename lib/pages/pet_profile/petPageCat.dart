import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/classes/animal.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';  // for formatting date

import 'package:pet_app/database_helper.dart';  // for DB
import 'package:pet_app/localNotifyManager.dart';

class petPageCat extends StatefulWidget {
  @override
  _petPageCatState createState() => _petPageCatState();
}

class _petPageCatState extends State<petPageCat> {

  Cat cat = Cat(id: 0, name: "", dataOfBirth: null, weight: 0, profilImage: null, breed: "");
  String weightStatus = "";
  bool loading;

  static const double pad = 10; //padding left, right
  
  @override
  void initState() {
    super.initState();
    getCatData();
  }

  Future<void> getCatData () async {
    setState(() {
      loading = true;
    });

    setState(() {
      cat.id = DatabaseHelper.instance.animalId;
    });

    // reading data from DB
    List<Map<String, dynamic>> row =
    await DatabaseHelper.instance.queryOne('Cat', cat.id);
    setState(() {
      // filling the cat object with received data
      cat.name = row[0]['name'];
      cat.dateOfBirth = DateTime.parse(row[0]['dateOfBirth']);
      cat.weight = row[0]['weight'];
      cat.profilImage = File(row[0]['profileImage']);
      cat.breed = row[0]['breed'];
    });
    String statusOfWeight = cat.breed != 'Another' ? await cat.check_weight() : "";

    setState(() {
      weightStatus = statusOfWeight;
      loading = false;
    });
  }

  final _picker = ImagePicker();

  File _image; // image of PET for class Animal !!!

  _imgFromCamera() async {
    PickedFile image = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
      // for updating photo
      cat.profilImage = _image;
      DatabaseHelper.instance.updatePetPhoto("Cat", cat.id, image.path.toString());
    });
  }

  //get image from Gallery
  _imgFromGallery() async {
    PickedFile image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
      // for updating photo
      cat.profilImage = _image;
      DatabaseHelper.instance.updatePetPhoto("Cat", cat.id, image.path.toString());
    });
  }


  //show picker to choose whether you want get image from camera or gallery
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
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

  //////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text("Pet's profile"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 0.0,
      ),
      body: loading ? CircularProgressIndicator() : Padding(
        padding: EdgeInsets.fromLTRB(pad, 10.0, pad, 0.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: (MediaQuery.of(context).size.width-2*pad)/2,
                  child: Card(
                    elevation: 3.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(pad, 10, pad, 5),
                          child: Text(
                            'NAME',
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(pad, 0, pad, 10),
                          child: Text(
                            '${cat.name}',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 26.0,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(pad, 0, pad, 0),
                          child: Divider(
                            //  height: 10.0,
                            color: Colors.black,
                            thickness: 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(pad, 10, pad, 5),
                          child: Text(
                            'AGE',
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(pad, 0, pad, 10),
                          child: Text(
                            "${cat.calculateAge()}",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 20.0,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //updating picture
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: (MediaQuery.of(context).size.width - 3*pad)/4,
                    backgroundImage: FileImage(cat.profilImage),
                  ),
                )
              ],
            ),
            /// data info
            SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 3.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date of birth',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${DateFormat('dd-MM-yyyy').format(cat.dateOfBirth)}',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2,
                            fontSize: 21.0,
                            //  fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /////
                Visibility(
                  visible: cat.breed!='Another',
                  child: Card(
                    elevation: 3.0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Breed',
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${cat.breed}',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 21.0,
                              //  fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ///////
                Card(
                  elevation: 3.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${cat.weight} kg',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2,
                            fontSize: 21.0,
                            //  fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //////
                //SizedBox(height: 15.0),
                Visibility(
                  visible: cat.breed!='Another',
                  child: Card(
                    elevation: 3.0,
                    child: Container(
                      color: weightStatus=='Normal' ? Colors.lightGreenAccent[400] : Colors.redAccent[400],
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weight status',
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            weightStatus,
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 21.0,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /////
              ],
            ),
            Divider(
              height: 20.0,
              color: Colors.black,
              thickness: 1.5,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
              ),
              label: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              icon: Icon(
                Icons.notifications,
                color: Colors.grey[800],
                size: 40.0,
              ),
              onPressed: () {
                print('Notifications');

                setState(() {
                  Navigator.pushNamed(
                    context, '/notificationPage',
                  );
                });
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              label: Text(
                'Update weight',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () async {
                print('Update weight');
                double weightController = -1;
                await showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text('New weight'),
                        content: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Weight (kg) : ',
                          ),
                          keyboardType: TextInputType.number,
                          // keyboard display numbers
                          onChanged: (val) {
                            // getting value from the TextField
                            weightController = double.parse(val);
                            print('new weight: $weightController');
                          },
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {Navigator.pop(context);},
                              child: Text("Cancel")
                          ),
                          TextButton(
                              onPressed: () async {
                                //print('new weight 2: $weightController');
                                if (weightController >=0) //function to check wether everything is ok
                                    {
                                  int i = await DatabaseHelper.instance.updateWeight('Cat',{
                                    'id' : cat.id,
                                    'name' : cat.name,
                                    'dateOfBirth' : cat.dateOfBirth.toString(),
                                    'weight' : weightController,
                                    'profileImage' : cat.profilImage.path.toString(),
                                    'breed' : cat.breed
                                  });
                                  cat.weight = weightController;
                                  String statusOfWeight = await cat.check_weight();

                                  setState(() {
                                    weightStatus = statusOfWeight;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Update")
                          ),
                        ],
                      );
                    }
                );
              },
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.grey[800],
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( //for deleting profil
        onPressed: () {
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text("Are you sure you want to delete this profil?"),
                  actions: [
                    TextButton(
                        onPressed: () {Navigator.pop(context);},
                        child: Text("No")
                    ),
                    TextButton(
                        onPressed:() async {
                          await deleteNotificationsFromDBAndLocalNtf('Cat', 'Cat', cat.id);
                          setState(() {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (Route<dynamic> route) => false
                            );
                          });
                          print('Deleted profile');

                        },
                        child: Text("Yes")
                    )
                  ],
                );
              }
          );
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
