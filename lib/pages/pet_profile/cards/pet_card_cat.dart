import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/classes/animal.dart';

class PetCardCat extends StatelessWidget {

  final Cat cat;
  final Function delete;
  final Function viewProfile;

  PetCardCat({this.cat, this.delete, this.viewProfile});


  @override
  Widget build(BuildContext context) {
    return Card(
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
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        'Cat',
                        style: TextStyle(
                          fontSize: 20.0,
                         // backgroundColor: Colors.lightBlueAccent,
                        )
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/cat.png'),
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
                  '${cat.getName()}',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(cat.profilImage),
                ),
              ],
            ),
            SizedBox(height: 8.0),
           /* FlatButton.icon(
              onPressed: delete,
              label: Text('Delete profile'),
              icon: Icon(Icons.delete),
            ),*/
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
