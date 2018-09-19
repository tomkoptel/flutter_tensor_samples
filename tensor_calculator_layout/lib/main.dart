import 'package:flutter/material.dart';

/**
 * Building a Calculator Layout using Dart's Flutter Framework - https://youtu.be/MvxyazbTkQg
 * Finishing our Calculator Application with Dart's Flutter Framework - https://youtu.be/jx9-RlMs350
 */
void main() => runApp(MaterialApp(
      title: "Calc Layout",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: CalcApp(),
    ));

class CalcApp extends StatefulWidget {
  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String input = "";
  String value = "";
  String operation = "z";
  double prevValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return MainState(
      inputValue: input,
      prevValue: prevValue,
      value: value,
      operation: operation,
      onPressed: _onPressed,
      child: CalculatorLayout(),
    );
  }

  bool _isNumber(String value) {
    if (value == null) {
      return false;
    }
    return double.parse(value, (e) => null) != null;
  }

  void _onPressed(keyValue) {
    switch (keyValue) {
      case "C":
        operation = null;
        value = "";
        setState(() {
          input = "";
        });
        break;
      case "%":
      case "_":
      case ".":
      case "<":
      case "x":
      case "+":
      case "-":
      case "/":
        operation = keyValue;
        value = "";
        prevValue = double.parse(input);
        setState(() {
          input = input + keyValue;
        });
        break;
      case "=":
        if (operation != null) {
          setState(() {
            switch (operation) {
              case "x":
                input = (prevValue * double.parse(value)).toStringAsFixed(0);
                break;
              case "+":
                input = (prevValue + double.parse(value)).toStringAsFixed(0);
                break;
              case "-":
                input = (prevValue - double.parse(value)).toStringAsFixed(0);
                break;
              case "/":
                input = (prevValue / double.parse(value)).toStringAsFixed(2);
                break;
            }
          });

          operation = null;
          prevValue = double.parse(input);
          value = "";
          break;
        }
        break;
      default:
        if (_isNumber(keyValue)) {
          if (operation != null) {
            setState(() {
              input = input + keyValue;
            });
            value = value + keyValue;
          } else {
            setState(() {
              input = "" + keyValue;
            });
            operation = 'z';
          }
        } else {
          _onPressed(keyValue);
        }
    }
  }
}

class MainState extends InheritedWidget {
  MainState(
      {Key key,
      Widget child,
      this.inputValue,
      this.prevValue,
      this.value,
      this.operation,
      this.onPressed})
      : super(key: key, child: child);
  final String inputValue;
  final double prevValue;
  final String value;
  final String operation;
  final Function onPressed;

  @override
  bool updateShouldNotify(MainState oldWidget) {
    return inputValue != oldWidget.inputValue;
  }

  static MainState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MainState);
  }
}

class CalculatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainState = MainState.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.blueGrey.withOpacity(0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      mainState.inputValue ?? '0',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 48.0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: <Widget>[
                    _makeBtn('C%</'),
                    _makeBtn('789x'),
                    _makeBtn('456-'),
                    _makeBtn('123+'),
                    _makeBtn('_0.='),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _makeBtn(String row) {
    List<String> token = row.split("");

    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token.map((e) {
          return CalcButton(keyValue: e);
        }).toList(),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  final String keyValue;

  const CalcButton({Key key, this.keyValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainState = MainState.of(context);
    return Expanded(
      flex: 1,
      child: FlatButton(
        shape: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 2.0,
            style: BorderStyle.solid),
        color: Colors.white,
        child: Text(
          keyValue,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 36.0,
              color: Colors.black54,
              fontStyle: FontStyle.normal),
        ),
        onPressed: () {
          mainState.onPressed(keyValue);
        },
      ),
    );
  }
}
