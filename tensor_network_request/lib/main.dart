import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**
 * Making Http requests and Using Json in Dart's Flutter Framework - https://youtu.be/xfdG8e9mgU4
 */

void main() => runApp(MaterialApp(
      home: NetworkApp(),
    ));

class NetworkApp extends StatefulWidget {
  @override
  _NetworkAppState createState() => _NetworkAppState();
}

class _NetworkAppState extends State<NetworkApp> {
  final url = "https://swapi.co/api/starships";
  List data;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });

    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Make Network Request with Flutter'),
          backgroundColor: Colors.amberAccent,
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("Name:  "),
                            Text(
                              data[index]["name"],
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("Model:  "),
                            Text(
                              data[index]["model"],
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.orangeAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
