import 'package:flutter/material.dart';
import 'package:pet_app/pages/home.dart';
import 'package:pet_app/pages/notifications/notificationPage.dart';
import 'package:pet_app/pages/notifications/chooseNotification[Adding].dart';
import 'package:pet_app/pages/notifications/addVetNotice.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // for choosing date in PL
import 'package:pet_app/pages/notifications/addPlayNotice.dart';
import 'package:pet_app/pages/notifications/addEatNotice.dart';
// creating pet profile imports
import 'package:pet_app/pages/pet_profile/addPetPage1.dart';
import 'package:pet_app/pages/pet_profile/addPetPage2Dog.dart';
import 'package:pet_app/pages/pet_profile/addPetPage2Cat.dart';
import 'package:pet_app/pages/pet_profile/petPageDog.dart';
import 'package:pet_app/pages/pet_profile/petPageCat.dart';


void main() async {

  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/notificationPage': (context) => notificationPage(),
        '/chooseNotification' : (context) => chooseNotification(),
        '/addVetNotice' : (context) => addVetNotice(),
        '/addPlayNotice' : (context) => addPlayNotice(),
        '/addEatNotice' : (context) => addEatNotice(),
        '/addPetPage1' : (context) => addPetPage1(),
        '/addPetPage2Dog' : (context) => addPetPage2Dog(),
        '/addPetPage2Cat' : (context) => addPetPage2Cat(),
        '/petPageDog' : (context) => petPageDog(),
        '/petPageCat' : (context) => petPageCat()
      },
    // for choosing date in PL language -start
  /*    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pl', 'PL'), // English, no country code
      ],*/
    // for choosing date in PL language -end
  ));
}