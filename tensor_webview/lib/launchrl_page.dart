import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class LaunchUrlPage extends StatelessWidget {
  final String defaultUrl;

  const LaunchUrlPage({Key key, @required this.defaultUrl}) : super(key: key);

  Future launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Launch Url Plugin")),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(defaultUrl),
            ),
            RaisedButton(
              child: Text("Open Link"),
              onPressed: () {
                launchUrl(defaultUrl);
              },
            )
          ],
        ),
      ),
    );
  }
}
