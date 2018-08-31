import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('text'),
        ),
        body: DragDropApp(),
      ),
    ));

class DragDropApp extends StatefulWidget {
  @override
  _DragDropAppState createState() => _DragDropAppState();
}

class _DragDropAppState extends State<DragDropApp> {
  static final Item defaultItem = Item(color: Colors.grey, label: 'Drag here!');
  Item caughtItem = defaultItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DragBox(
          initPos: Offset(0.0, 0.0),
          label: 'Box One',
          itemColor: Colors.lime,
        ),
        DragBox(
          initPos: Offset(100.0, 0.0),
          label: 'Box Two',
          itemColor: Colors.orange,
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: DragTarget(onAccept: (Item item) {
            caughtItem = item;
          }, builder: (BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            return Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                  color:
                      accepted.isEmpty ? caughtItem.color : accepted[0].color),
              child: Center(
                  child: Text(
                      accepted.isEmpty ? caughtItem.label : accepted[0].label)),
            );
          }),
        )
      ],
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(
      {@required this.initPos, @required this.label, @required this.itemColor});

  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
          data: Item(label: widget.label, color: widget.itemColor),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            height: 120.0,
            width: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: _buildTextStyle(15.0),
              ),
            ),
          ),
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: _buildTextStyle(),
              ),
            ),
          )),
    );
  }

  TextStyle _buildTextStyle([double textSize = 20.0]) {
    return TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: textSize);
  }
}

class Item {
  final String label;
  final Color color;

  Item({this.label, this.color});

  @override
  String toString() {
    return "label: $label";
  }
}
