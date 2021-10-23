import 'package:flutter/material.dart';
import 'package:pablo_villa_4_2021_2_p1/screens/characters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Psychonauts',
      home: CharactersScreen(),
    );
  }
}