import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  bool _isFiltered = false;
  String _search = '';

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
        actions: <Widget>[
          _isFiltered 
          ? IconButton(onPressed: _removeFilter, icon: Icon(Icons.filter_alt_outlined))
          : IconButton(onPressed: _showFilter, icon: Icon(Icons.filter_alt_rounded)),
        ],
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

    var connectivityResult = await Connectivity().checkConnectivity();
    
    if(connectivityResult == ConnectivityResult.none)
    {
      setState(() {
        _showLoader = false;
      });

      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verify your internet connection',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
          
      return;
    }

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
  }

  Widget _getCharactersContent() {
    return _characters.length == 0
    ? _noContent()
    : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Column(
        children: [
          Image(
              image: AssetImage("assets/loader.gif"),
              width: 150,
          ),
          Text(
            _isFiltered
            ?'Characters not found with that search criteria'
            :'There are not characters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
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
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(2),
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


  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Text('Filter Psychonauts'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Write the first characters of the Psychonaut'),
              SizedBox(height: 10),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search criteria...',
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search_rounded)
                ),
                onChanged: (value)
                {
                  setState(() {
                    _search = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancel')),
              TextButton(
              onPressed: () => _filter(), 
              child: Text('Filter')),
          ],
        );
      }
    );
  }

  void _filter(){
    if(_search.isEmpty)
    {
      return;
    }

    List<Character> filteredList = [];

    for (var character in _characters) {
      if(character.name.toLowerCase().contains(_search.toLowerCase()))
      {
        filteredList.add(character);
      }
    }

    setState(() {
      _characters = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
      _characters = [];
    });

    _getCharacters();
  }

}