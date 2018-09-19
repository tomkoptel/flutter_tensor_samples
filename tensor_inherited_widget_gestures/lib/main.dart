import 'dart:math';
import 'package:flutter/material.dart';

/**
 * Using Inherited Widgets and Gesture Detectors in Dart's Flutter Framework - https://youtu.be/4I68ilX0Y24
 */

void main() => runApp(MaterialApp(
      title: 'Random Squares',
      home: App(),
    ));

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Random _random = Random();
  Color color = Colors.amber;

  void _onTap() {
    setState(() {
      color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorState(
      color: color,
      onTap: _onTap,
      child: BoxTree(),
    );
  }
}

class ColorState extends InheritedWidget {
  ColorState({
    Key key,
    this.color,
    this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  final Color color;
  final Function onTap;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return this.color != oldWidget.color;
  }

  static ColorState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}

class BoxTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[Box(), Box()],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorState = ColorState.of(context);
    return GestureDetector(
        onTap: colorState.onTap,
        child: Container(
          width: 50.0,
          height: 50.0,
          margin: EdgeInsets.only(left: 100.0),
          color: colorState.color,
        ));
  }
}
