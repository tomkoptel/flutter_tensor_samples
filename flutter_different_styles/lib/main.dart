import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "Styling Flutter",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final simpleText = Text(
      "Styling Stuff",
      style: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w900, fontFamily: "Georgia"),
    );
    final richText = RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.grey),
            children: [TextSpan(text: "Styling "), TextSpan(text: "Stuff")]));
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity(),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.black),
                // borderRadius: BorderRadius.circular(1000.0),
                gradient: RadialGradient(
                    colors: <Color>[Color(0xffef5350), Color(0x00ef5350)]),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xc0000000),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 4.0),
                  BoxShadow(
                      color: Color(0x80000000),
                      offset: Offset(0.0, 6.0),
                      blurRadius: 20.0),
                ]),
            alignment: Alignment.center,
            width: 280.0,
            height: 280.0,
            child: richText,
          ),
        ),
      ),
    );
  }
}
