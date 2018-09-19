import 'package:flutter/material.dart';

/**
 * Building a Multi-Page Application with Dart's Flutter Mobile Framework - https://youtu.be/b2fgMCeSNpY
 */

final ThemeData theme =
    ThemeData(canvasColor: Colors.lightGreen, accentColor: Colors.red);

void main() => runApp(MaterialApp(
      home: MultiPage(),
      theme: theme,
    ));

class MultiPage extends StatefulWidget {
  @override
  _MultiPageState createState() => _MultiPageState();
}

class _MultiPageState extends State<MultiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi page'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: FlatButton(
            onPressed: () {
              Navigator.push(context, PageTwo());
            },
            child: Text("Go to page 2"),
          ),
        ),
      ),
    );
  }
}

class PageTwo extends MaterialPageRoute<Null> {
  PageTwo()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Page 2'),
              elevation: 1.0,
            ),
            body: Container(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, PageThree());
                    },
                    child: Text("Last Page"),
                  ),
                )),
          );
        });
}

class PageThree extends MaterialPageRoute<Null> {
  PageThree()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Last page!'),
              backgroundColor: Theme.of(context).accentColor,
              elevation: 2.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: MaterialButton(
                    onPressed: () {
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                    child: Text("Go home")),
              ),
            ),
          );
        });
}
