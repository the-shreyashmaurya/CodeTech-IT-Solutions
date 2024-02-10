import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    pref: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences pref;
  MyApp({super.key, required this.pref});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      home: MainScreen(
        prefs: pref,
      ),
    );
  }
}
