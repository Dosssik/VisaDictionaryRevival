import 'package:flutter/material.dart';
import 'package:give_me_visa/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дайте визу',
      theme: ThemeData.dark(),
      home: CountriesListPage(),
    );
  }
}

