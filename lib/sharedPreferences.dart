import 'package:shared_preferences/shared_preferences.dart';

incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  await prefs.setInt('counter', counter);
}

getCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('counter') ?? 0;
}