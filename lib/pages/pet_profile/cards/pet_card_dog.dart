import 'package:flutter/material.dart';
import 'package:pet_app/classes/animal.dart';

class PetCardDog extends StatelessWidget {

  final Dog dog;
  final Function delete;
  final Function viewProfile;

  PetCardDog({this.dog, this.delete, this.viewProfile});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        'Dog',
                        style: TextStyle(
                          fontSize: 20.0,
                          //backgroundColor: Colors.orangeAccent,
                        )
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/dog.png'),
                  radius: 20,
                ),
              ],
            ),
            Divider(
              height: 20.0,
              color: Colors.grey[800],
              thickness: 1.5,
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dog.getName()}',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(dog.profilImage),
                ),
              ],
            ),
            // Text(
            //   'Age ${dog.calculateAge().toString()}',
            //   style: TextStyle(
            //     fontSize: 14.0,
            //     color: Colors.grey[800],
            //   ),
            // ),
            SizedBox(height: 8.0),
            FlatButton.icon(
                onPressed: viewProfile,
                icon: Icon(Icons.assignment_sharp),
                label: Text('View profile')
            )
          ],
        ),
      ),
    );
  }
}
