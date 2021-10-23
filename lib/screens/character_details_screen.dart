import 'package:flutter/material.dart';

import 'package:pablo_villa_4_2021_2_p1/models/character.dart';


class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name)
      ),
      body: Center(
        child: Text('prube'),
      ),
    );
  }
}