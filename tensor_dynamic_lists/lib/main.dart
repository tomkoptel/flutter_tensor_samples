import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/**
 * Building Dynamic Lists with Streams in Dart's Flutter Framework - https://youtu.be/hvvYA1N-tEc
 */

void main() {
  return runApp(MaterialApp(
    title: 'Photo Streamer',
    theme: ThemeData(
      primaryColor: Colors.green,
    ),
    home: PhotoList(),
  ));
}

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  final String url = "https://jsonplaceholder.typicode.com/photos";
  List<Photo> photos = [];
  StreamController<Photo> streamController;

  @override
  void initState() {
    super.initState();
    print('_PhotoListState#initState()');
    streamController = StreamController.broadcast();
    streamController.stream
        .listen((photo) => setState(() => photos.add(photo)));
    load();
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  load() async {
    var client = http.Client();
    var request = http.Request('get', Uri.parse(url));
    var response = await client.send(request);

    response.stream
        .transform(Utf8Decoder())
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Photo.fromJsonMap(map))
        .pipe(streamController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Streams'),
      ),
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (_, int index) {
            return _makeElement(index);
          }),
    );
  }

  Widget _makeElement(int index) {
    if (index >= photos.length) {
      return null;
    }
    var photo = photos[index];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            photo.url,
            height: 150.0,
            width: 150.0,
          ),
          Text(photo.title)
        ],
      ),
    );
  }
}

class Photo {
  final String title;
  final String url;

  Photo.fromJsonMap(Map map)
      : title = map['title'],
        url = map['url'];

  @override
  String toString() {
    return "title: $title url: $url";
  }
}
