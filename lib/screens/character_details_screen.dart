import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          title: Center(
            child: Text(
              widget.character.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ) 
          )
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: _showCharacterDetails(),
      ),
    );
  }

  Widget _showCharacterDetails() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Image.network(
            widget.character.img,
            width: 125,
          ),          
          Text(
            widget.character.gender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          Container(
            child: _showPowersInTable(),
          )
        ]
      )
    );
  }

  Widget _showPowersInTable() {
    return DataTable(sortColumnIndex: 2,
      sortAscending: false,
      columns: [
        DataColumn(label: Text("Power")),
        DataColumn(label: Text("Description")),
        DataColumn(label: Text("image")),
      ],
      rows:
        widget.character.psiPowers.map((e) => DataRow(
            cells: [
              DataCell(
                Text(e.name)
              ),
              DataCell(
                Text(e.description)
              ),
              DataCell(
                Image.network(e.img)
              ),
            ])
      ).toList(),
    );
  }
}