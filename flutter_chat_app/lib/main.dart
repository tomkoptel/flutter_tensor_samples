import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final ThemeData iOSTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark,
);
final ThemeData androidTheme = ThemeData(
  primarySwatch: Colors.blue[600],
  primaryColor: Colors.green[100],
);

const String defaultUserName = "Hon Hon";

void main() => runApp(new ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var defaultTargetPlatform = Theme.of(context).platform;
    return new MaterialApp(
        title: "Chat App",
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? iOSTheme
            : androidTheme,
        home: Chat());
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = TextEditingController();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    var defaultTargetPlatform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat application"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
            reverse: true,
            padding: EdgeInsets.all(6.0),
          ),
        ),
        Divider(height: 1.0),
        Container(
          child: _buildComposer(context),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
        ),
      ]),
    );
  }

  Widget _buildComposer(BuildContext context) {
    var theme = Theme.of(context);
    var submitFunc = () {
      return _isWriting ? () => _submitMsg(_textController.text) : null;
    };

    return IconTheme(
        data: IconThemeData(color: theme.accentColor),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 9.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration: InputDecoration.collapsed(
                      hintText: "Enter some text to send a message"),
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  child: theme.platform == TargetPlatform.iOS
                      ? CupertinoButton(
                          child: Text("Submit"),
                          onPressed: submitFunc(),
                        )
                      : IconButton(
                          icon: Icon(Icons.message),
                          onPressed: submitFunc(),
                        ),
                ),
              ],
            )));
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });

    Msg msg = Msg(
      txt: txt,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 800)),
    );

    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    _messages.forEach((Msg msg) {
      msg.animationController.dispose();
    });
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ),
      axisAlignment: 0.0,
      child: buildContainer(theme),
    );
  }

  Container buildContainer(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text(defaultUserName[0]),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  defaultUserName,
                  style: theme.textTheme.subhead,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: Text(txt),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
