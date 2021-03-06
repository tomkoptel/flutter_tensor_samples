import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math';

/**
 * Advanced Physics Based Animations in Dart's Flutter Framework - https://youtu.be/LHZ0KSvTTqQ
 */

const BOX_COLOR = Colors.cyan;

void main() => runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.red),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Physics app')),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
            bottom: 20.0,
          ),
          child: PhysicsBox(
            boxPosition: 0.5,
          ),
        ),
      ),
    );
  }
}

class PhysicsBox extends StatefulWidget {
  final boxPosition;

  const PhysicsBox({Key key, this.boxPosition = 0.0}) : super(key: key);

  _BoxState createState() => _BoxState();
}

class _BoxState extends State<PhysicsBox> with SingleTickerProviderStateMixin {
  double boxPosition;
  double boxPositionOnStart;
  Offset start;
  Offset point;

  AnimationController animationController;
  ScrollSpringSimulation simulation;

  @override
  void initState() {
    super.initState();

    boxPosition = widget.boxPosition;
    simulation = ScrollSpringSimulation(
        SpringDescription(mass: 1.0, stiffness: 1.0, damping: 1.0),
        0.0,
        1.0,
        0.0);
    animationController = AnimationController(vsync: this)
      ..addListener(() {
        print('${simulation.x(animationController.value)}');
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: startDrag,
      onPanUpdate: onDrag,
      onPanEnd: endDrag,
      child: CustomPaint(
          painter: BoxPainter(
              color: BOX_COLOR,
              boxPosition: boxPosition,
              boxPositionOnStart: boxPositionOnStart ?? boxPosition,
              touchPoint: point),
          child: Container()),
    );
  }

  void startDrag(DragStartDetails details) {
    start = (context.findRenderObject() as RenderBox)
        .globalToLocal(details.globalPosition);
    boxPositionOnStart = boxPosition;
  }

  void onDrag(DragUpdateDetails details) {
    setState(() {
      point = (context.findRenderObject() as RenderBox)
          .globalToLocal(details.globalPosition);

      final dragVelocity = start.dy - point.dy;
      final normalDragVelocity =
          (dragVelocity / context.size.height).clamp(-1.0, 1.0);
      boxPosition = (boxPositionOnStart + normalDragVelocity).clamp(0.0, 1.0);
    });
  }

  void endDrag(DragEndDetails details) {
    setState(() {
      start = null;
      point = null;
      boxPositionOnStart = null;
    });
  }
}

class BoxPainter extends CustomPainter {
  final double boxPosition;
  final double boxPositionOnStart;
  final Color color;
  final Offset touchPoint;
  final Paint boxPaint;
  final Paint dropPaint;

  BoxPainter(
      {this.boxPosition = 0.0,
      this.boxPositionOnStart = 0.0,
      this.color = Colors.grey,
      this.touchPoint})
      : boxPaint = Paint(),
        dropPaint = Paint() {
    boxPaint.color = this.color;
    boxPaint.style = PaintingStyle.fill;
    dropPaint.color = Colors.grey;
    dropPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    final boxValueY = size.height - (size.height * boxPosition);
    final prevBoxValueY = size.height - (size.height * boxPositionOnStart);
    final midPointY = ((boxValueY - prevBoxValueY) * 1.2 + prevBoxValueY)
        .clamp(0.0, size.height);

    Point left, mid, right;
    left = Point(-100.0, prevBoxValueY);
    right = Point(size.width + 50, prevBoxValueY);
    if (touchPoint != null) {
      mid = Point(touchPoint.dx, midPointY);
    } else {
      mid = Point(size.width / 2, midPointY);
    }

    final path = Path();
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(mid.x - 100.0, mid.y, left.x, left.y);
    path.lineTo(0.0, size.height);
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(mid.x + 100.0, mid.y, right.x, right.y);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, boxPaint);
    canvas.drawCircle(Offset(right.x, right.y), 10.0, dropPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
