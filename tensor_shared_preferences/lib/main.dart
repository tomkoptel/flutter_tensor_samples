import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Making use of Shared Preferences, Flex Widgets and Dismissibles with Dart's Flutter framework - https://youtu.be/IvrAAMQnj4k
 */

void main() => runApp(MaterialApp(
      home: SharePrefApp(),
    ));

class SharePrefApp extends StatefulWidget {
  _SharePrefAppState createState() => _SharePrefAppState();
}

class _SharePrefAppState extends State<SharePrefApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _controller = TextEditingController();
  List<String> listOne, listTwo;

  @override
  void initState() {
    super.initState();
    listOne = [];
    listTwo = [];
  }

  Future<Null> addString() async {
    final SharedPreferences prefs = await _prefs;
    listOne.add(_controller.text);
    prefs.setStringList("list", listOne);
    setState(() {
      _controller.text = '';
    });
  }

  Future<Null> clearItems() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    setState(() {
      listOne = [];
      listTwo = [];
    });
  }

  Future<Null> getStrings() async {
    final SharedPreferences prefs = await _prefs;
    listTwo = prefs.getStringList("list");
    setState(() {});
  }

  Future<Null> updateStrings(String str) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      listOne.remove(str);
    });

    prefs.setStringList('list', listOne);
  }

  @override
  Widget build(BuildContext context) {
    getStrings();
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharedpref App'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: "Type in something..."),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  addString();
                },
              ),
              RaisedButton(
                child: Text("Clear"),
                onPressed: () {
                  clearItems();
                },
              ),
              Flex(
                  direction: Axis.vertical,
                  children: listTwo == null
                      ? []
                      : listTwo.map((String s) {
                          return Dismissible(
                            key: Key(s),
                            child: ListTile(title: Text(s)),
                            onDismissed: (direction) {
                              updateStrings(s);
                            },
                          );
                        }).toList())
            ],
          ),
        ));
  }
}
