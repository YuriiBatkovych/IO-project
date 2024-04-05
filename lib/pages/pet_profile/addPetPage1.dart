import 'package:flutter/material.dart';


class addPetPage1 extends StatefulWidget {
  @override
  _addPetPage1State createState() => _addPetPage1State();
}

class _addPetPage1State extends State<addPetPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Choose your animal'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 0.0,
      ),
      body: Padding(
        padding : EdgeInsets.fromLTRB(20.0, 160.0, 20.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
                onPressed:(){
                  setState(() {
                    Navigator.pushNamed(
                        context, '/addPetPage2Dog',
                    );
                  });
                  },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset('assets/dog.png')
                ),
            ),
            //SizedBox(width: 55.0),
            TextButton(
              onPressed:(){
                setState(() {
                  Navigator.pushNamed(
                      context, '/addPetPage2Cat',
                  );
                });
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset('assets/cat.png')
              ),
            ),
          ],
        )
      ),
    );
  }
}
