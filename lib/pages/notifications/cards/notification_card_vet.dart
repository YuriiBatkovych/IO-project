import 'package:flutter/material.dart';
import 'package:pet_app/classes/notification.dart';
import 'package:intl/intl.dart';  //DateFormat

class NotificationCardVet extends StatelessWidget {

  final NoticeVet vetNtf;
  final Function delete;

  NotificationCardVet({this.vetNtf, this.delete});

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
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Vet',
                      style: TextStyle(
                        fontSize: 20.0,
                      )
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/vet_icon.png'),
                  radius: 20,
                ),
              ],
            ),
            Divider(
              height: 20.0,
              color: Colors.grey[800],
              thickness: 1.5,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${vetNtf.infoText}'),
                ],
              ),
            ),
            SizedBox(height: 3.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Date: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${DateFormat('dd-MM-yyyy').format(vetNtf.date)}'),
                ],
              ),
            ),
            SizedBox(height: 3.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Remind: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${vetNtf.remindTime.toString()} day(s) before'),
                ],
              ),
            ),
            SizedBox(height: 3.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Vaccination: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${vetNtf.vaccination ? 'YES' : 'NO'}'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            FlatButton.icon(
              onPressed: delete,
              label: Text('Delete notification'),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
