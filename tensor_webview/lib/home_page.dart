import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomePage extends StatefulWidget {
  final String defaultUrl;

  const HomePage({Key key, @required this.defaultUrl}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final webView = FlutterWebviewPlugin();
  var url;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    webView.close();

    url = widget.defaultUrl;
    controller = TextEditingController(text: widget.defaultUrl);
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    webView.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
              ),
            ),
            RaisedButton(
              child: Text("Open Webview"),
              onPressed: () {
                Navigator.of(context).pushNamed("/webview");
              },
            ),
            RaisedButton(
              child: Text("Open URL launcher"),
              onPressed: () {
                Navigator.of(context).pushNamed("/url_launcher");
              },
            ),
          ],
        ),
      ),
    );
  }
}
