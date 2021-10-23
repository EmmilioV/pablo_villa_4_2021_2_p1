import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pablo_villa_4_2021_2_p1/helpers/constans.dart';
import 'package:pablo_villa_4_2021_2_p1/models/character.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _characters = [];

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Personajes de psiconauta'),
        )
      ),
      body: Center(
        child: _getCharactersContent(),
      ),
    );
  }

  void _getCharacters() async {
    var url = Uri.parse(Constans.apiUrl);
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      }
    );
    
    setState(() {
      
    });

    var body = response.body;
    var decodedJson = jsonDecode(body);
    if(decodedJson != null){
      for(var item in decodedJson)
      {
        _characters.add(Character.fromJson(item));
      }
    }

    print(_characters);
  }

  Widget _getCharactersContent() {
    return _characters.length == 0
    ? _noContent()
    : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Text(
        'No hay personajes almacenados'
      ) 
    );
  }

  Widget _getListView() {
    return ListView(
        children: _characters.map((e) {
          return InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                      e.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Image.network(e.img)
                ],
              ),
            )
          );
        }).toList(),
      );
  }
}