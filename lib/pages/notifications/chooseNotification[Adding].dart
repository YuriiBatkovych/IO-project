import 'package:flutter/material.dart';

class chooseNotification extends StatefulWidget {
  @override
  _chooseNotificationState createState() => _chooseNotificationState();
}

class _chooseNotificationState extends State<chooseNotification> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your notification'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      Navigator.pushNamed(
                        context, '/addVetNotice',
                      );
                    });
                  },
                  child: Text(
                      'Vet'
                  ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.pushNamed(
                      context, '/addEatNotice',
                    );
                  });
                },
                child: Text(
                    'Eating'
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.pushNamed(
                      context, '/addPlayNotice',
                    );
                  });
                },
                child: Text(
                    'Playing'
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
