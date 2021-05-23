import 'package:pet_app/classes/breed.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pet_app/database_helper.dart';   // for managing DB
import 'package:intl/intl.dart';  // for formatting dateofBirth
import 'package:pet_app/functions/control_functions.dart';


class addPetPage2Cat extends StatefulWidget {
  @override
  _addPetPage2CatState createState() => _addPetPage2CatState();
}

class _addPetPage2CatState extends State<addPetPage2Cat> {

  final _picker = ImagePicker();

  File _image; // image of PET for class Animal

  String nameController;
  String weightController;   //data for class Animal
  DateTime dateOfBirthController;
  var image_path = "";
  bool showTextInsteadOfDate = true;  // for showing "choose date" and after show chosen date
  DateFormat dateFormatter = DateFormat('dd-MM-yyyy');  // for formatting dateOfBirth

  List<String> _breeds = ['British Shorthair', 'Scottish Fold', 'Maine Coon', 'Kurilian bobtail', 'Another']; //list of cat's breeds

  List<DropdownMenuItem<String>> _dropdownMenuItems;  //list from which we will choose breed on page
  String _chosenBreed; //breed chosen by user

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_breeds);
    _chosenBreed = _dropdownMenuItems[0].value;
    super.initState();
  }

  //this function creates list from which we will choose breed on page
  List<DropdownMenuItem<String>> buildDropdownMenuItems(List breeds) {
    List<DropdownMenuItem<String>> items = [];
    for(String breed in breeds){
      items.add(DropdownMenuItem(value: breed, child: Text(breed)));
    }
    return items;
  }

  //this function set breed chosen by user as a value of _chosenbreed
  onChangedDropdownButton(String chosenBreed) {
    setState(() {
      _chosenBreed = chosenBreed;
    });
  }


  //get image from camera
  _imgFromCamera() async {
    PickedFile image = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
      image_path = image.path;  // needed for DB
    });
  }

  //get image from Gallery
  _imgFromGallery() async {
    PickedFile image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
      image_path = image.path;  // needed for DB
    });
  }

  // for choosing date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
     // locale : const Locale("pl","PL"),
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days:365*20)),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null)
      setState(() {
        dateOfBirthController = pickedDate;
        showTextInsteadOfDate = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text("Fill in data about your cat"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          child: Column(
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blueAccent,
                    child: _image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name : ',
                        ),
                        onChanged: (val) {  // getting value from the TextField
                          setState(() {
                            nameController = val;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Weight (kg) : ',
                        ),
                        keyboardType: TextInputType.number,  // keyboard display numbers
                        onChanged: (val) {  // getting value from the TextField
                          setState(() {
                            weightController = val;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      //choosing date --start
                      Row(
                        children: [
                          Text(
                            'Date of birth ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                '${showTextInsteadOfDate ? 'choose date' : dateFormatter.format(dateOfBirthController)}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              )
                          ),
                        ],
                      ),
                      //choosing date --end
                      //SizedBox(height: 5.0),
                      Center(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Breed ",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            DropdownButton(
                              value: _chosenBreed,
                              items: _dropdownMenuItems,
                              onChanged: onChangedDropdownButton,
                              //dropdownColor: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3.0,
                  primary: Colors.redAccent,
                ),
                onPressed: () async {               //want create pet's profil

                  //verify data correction start

                  if(!verify_animal_data(nameController, dateOfBirthController,
                      weightController, _chosenBreed))
                    {

                      String alert = "";

                      if(!verify_name_data(nameController)) {
                        alert = 'Please add name of cat';
                      }
                      else if(!verify_weight_data(weightController)) {
                        alert = 'Please correct weight data';
                      }
                      else if(!verify_dateofBirth_data(dateOfBirthController)) {
                        alert = 'Please add date of birth data';
                      }

                      await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(alert),
                                actions: [
                                  TextButton(
                                      onPressed: () {Navigator.pop(context);},
                                      child: Text("OK")
                                  )
                                ],
                              );
                            }
                        );
                        return;

                    }

                  if(image_path.toString() == ''){
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Please add image of cat'),
                            actions: [
                              TextButton(
                                  onPressed: () {Navigator.pop(context);},
                                  child: Text("OK")
                              )
                            ],
                          );
                        }
                    );
                    return;
                  }

                  //verify data correction ends

                  // saving pet profile to DB
                  int i = await DatabaseHelper.instance.insert('Cat',{
                    'name' : nameController,
                    'dateOfBirth' : dateOfBirthController.toString(),
                    'weight' : double.parse(weightController),
                    'profileImage' : image_path.toString(),
                    'breed' : _chosenBreed
                  });
                  print('i: $i');
                  List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll('Cat');
                  print(queryRows);

                  setState(() {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (_) => false
                    );
                  });
                },
                child: Text(
                  'Create profile',
                  style: TextStyle(
                    // color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
