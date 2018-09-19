import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

/**
 * The Basics of Animation with Dart's Flutter Framework - https://youtu.be/5urRyqOwTuo
 */

void main() => runApp(MaterialApp(
      home: AnimSample(),
    ));

class AnimSample extends StatefulWidget {
  @override
  _AnimSampleState createState() => _AnimSampleState();
}

class _AnimSampleState extends State<AnimSample>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    animation = Tween(begin: 0.0, end: 500.0).animate(animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: LogoAnimation(animation: animation),
    );
  }
}

class LogoAnimation extends AnimatedWidget {
  LogoAnimation({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
