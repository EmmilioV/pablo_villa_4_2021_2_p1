import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pablo_villa_4_2021_2_p1/helpers/constans.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Characters> _characters = [];

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes de psiconauta'),
      ),
      body: Center(
        child: Text('personajes')),
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
    print(response);
  }
}