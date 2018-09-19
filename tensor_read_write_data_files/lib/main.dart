import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/**
 * Reading and Writing Data and Files with Path Provider using Dart's Flutter Framework - https://youtu.be/Hqqz2BaPUis
 */

void main() => runApp(MaterialApp(
    home: Home(
      storage: Storage(),
    ),
    title: 'Read-Write Data File'));

class Home extends StatefulWidget {
  final Storage storage;

  Home({Key key, @required this.storage}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  String state;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }

  void writeData() {
    widget.storage
        .writeData(controller.text)
        .then((_) => widget.storage.readData())
        .then((newState) {
      setState(() {
        state = newState;
        controller.text = '';
      });
    });
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read-Write Data File'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('${state ?? "File is empty"}'),
              TextField(
                controller: controller,
                decoration:
                    InputDecoration(hintText: 'The text will be saved in file'),
              ),
              RaisedButton(
                onPressed: writeData,
                child: Text('Write to file'),
              ),
              RaisedButton(
                onPressed: getAppDirectory,
                child: Text('Get Dir Path'),
              ),
              FutureBuilder<Directory>(
                  future: _appDocDir,
                  builder: (BuildContext context,
                      AsyncSnapshot<Directory> snapshot) {
                    var text = Text('');
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        text = Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        text = Text('Path: ${snapshot.data.path}');
                      } else {
                        text = Text('Unavailable');
                      }
                    }
                    return text;
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      final body = await file.readAsString();
      print(body);
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data", mode: FileMode.append, flush: true);
  }
}
