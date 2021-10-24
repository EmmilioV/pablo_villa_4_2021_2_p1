import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pablo_villa_4_2021_2_p1/components/loader_component.dart';
import 'package:pablo_villa_4_2021_2_p1/helpers/constans.dart';
import 'package:pablo_villa_4_2021_2_p1/models/character.dart';
import 'package:pablo_villa_4_2021_2_p1/screens/character_details_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _characters = [];
  bool _showLoader = false;

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
          child: Text('Psychonauts characters'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: "Loader...") : _getCharactersContent(),
      ),
    );
  }

  void _getCharacters() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse(Constans.apiUrl);
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      }
    );
    
    setState(() {
      _showLoader = false;
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
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CharacterDetailsScreen(
                    character: e)
                )
              );
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            e.img,
                            height: 100,
                            width: 100,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey
                            ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.arrow_right_sharp),
                      ],
                    )
                  ],
                ),
              ),
            )
          );
        }).toList(),
      );
  }
}