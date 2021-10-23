import 'package:flutter/material.dart';

import 'package:pablo_villa_4_2021_2_p1/models/character.dart';
import 'package:pablo_villa_4_2021_2_p1/models/psi_power.dart';


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
        child: _showCharacterDetails(),
      ),
    );
  }

  Widget _showCharacterDetails() {
    return SingleChildScrollView(
      child: Column(
        children:
        [
          Image.network(widget.character.img),
          Text('Gender => ${widget.character.gender}'),
        ]
      )
    );
  }
}