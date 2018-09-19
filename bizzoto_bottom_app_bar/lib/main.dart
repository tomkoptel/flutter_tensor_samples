import 'package:flutter/material.dart';

/*
 * Flutter: BottomAppBar Navigation with FAB
 * https://medium.com/coding-with-flutter/flutter-bottomappbar-navigation-with-fab-8b962bb55013
 */
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter: BottomAppBar Navigation with FAB'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
          elevation: 2.0,
        ),
        bottomNavigationBar: FABBottomAppBar(
            onTabSelected: (_) {},
            shape: CircularNotchedRectangle(),
            color: Colors.grey,
            selectedColor: Colors.blue,
            height: 60.0,
            items: [
              FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
              FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
              FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
              FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
            ]));
  }
}

class FABBottomAppBarItem {
  final IconData iconData;
  final String text;

  FABBottomAppBarItem({@required this.iconData, @required this.text});
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape shape;
  final ValueChanged<int> onTabSelected;

  FABBottomAppBar({
    Key key,
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.shape,
    this.onTabSelected,
  }) : super(key: key) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(_selectIndex);
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
          item: widget.items[index], index: index, onPressed: _updateIndex);
    });

    return BottomAppBar(
      shape: widget.shape,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: items,
      ),
    );
  }

  Widget _buildTabItem(
      {FABBottomAppBarItem item, int index, Function(int index) onPressed}) {
    Color color = _selectIndex == index ? widget.selectedColor : widget.color;

    return Expanded(
      child: Container(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
              onTap: () => onPressed(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    item.iconData,
                    color: color,
                    size: widget.iconSize,
                  ),
                  Text(
                    item.text,
                    style: TextStyle(color: color),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
