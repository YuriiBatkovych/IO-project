import 'package:flutter/material.dart';
import 'package:pet_app/classes/notification.dart';

class NotificationCardEat extends StatelessWidget {

  final NoticeEat eatNtf;
  final Function delete;

  NotificationCardEat({this.eatNtf, this.delete});


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
                        'Eating',
                        style: TextStyle(
                          fontSize: 20.0,
                        )
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/eat_icon.jpg'),
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
                  TextSpan(text: '${eatNtf.infoText}'),
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
                    text: 'Time: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${eatNtf.time.format(context)}'),
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
                    text: 'Remind everyday: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${eatNtf.everyDay ? 'YES' : 'NO'}'),
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
