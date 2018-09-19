import 'package:flutter/material.dart';

/**
 * Building a Temperature Conversion Application using Dart's Flutter Framework - https://youtu.be/5tioWH6rWLc
 */

ThemeData appTheme = ThemeData.light().copyWith(
  accentColor: Colors.red,
  toggleableActiveColor: Colors.green,
  primaryColor: Colors.green,
);

void main() => runApp(MaterialApp(
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator App'),
        ),
        body: CalcApp(),
      ),
    ));

class CalcApp extends StatefulWidget {
  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  double input;
  double output;
  bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Input value in ${fOrC ? "Celsius" : "Fahrenheit"}'),
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0;
        }
      },
    );
    Container tempSwitch = Container(
      child: Column(
        children: <Widget>[
          Text('Choose Fahrenheit or Celsius'),
          Row(
            children: <Widget>[
              Text("F"),
              _fOrCradio(value: false),
              Text("C"),
              _fOrCradio(value: true),
            ],
          ),
        ],
      ),
    );
    Container calcBtn = Container(
      child: RaisedButton(
        child: Text('Calculate'),
        onPressed: () {
          fOrC
              ? output = (input * 9 / 5) + 32
              : output = (input - 32) * (5 / 9);

          AlertDialog alertDialog = AlertDialog(
            content: fOrC
                ? Text(
                    "${input.toStringAsFixed(3)} C: ${output.toStringAsFixed(3)} F")
                : Text(
                    "${input.toStringAsFixed(3)} F: ${output.toStringAsFixed(3)} C"),
          );
          showDialog(context: context, child: alertDialog);
        },
      ),
    );

    return Container(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: <Widget>[inputField, tempSwitch, calcBtn],
        ),
      ),
    );
  }

  Widget _fOrCradio({bool value = false}) {
    return Radio<bool>(
      groupValue: fOrC,
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          fOrC = newValue;
        });
      },
    );
  }
}
