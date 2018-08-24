import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: InputBox(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    ));

class InputBox extends StatefulWidget {
  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool loggedIn = false;
  String _email, _username, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      appBar: AppBar(
        title: Text('Input boxes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: loggedIn
            ? Center(
                child: Column(
                  children: <Widget>[
                    Text('Welcome $_username'),
                    RaisedButton(
                      child: Text("Log Out"),
                      onPressed: _logOut,
                    )
                  ],
                ),
              )
            : Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(labelText: 'Email:'),
                      validator: (str) {
                        return !str.contains('@') ? 'Not valid email' : null;
                      },
                      onSaved: (str) {
                        _email = str;
                      },
                    ),
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(labelText: 'Username:'),
                      validator: (str) {
                        return str.length <= 5 ? "Not a valid username!" : null;
                      },
                      onSaved: (str) {
                        _username = str;
                      },
                    ),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password:'),
                      validator: (str) {
                        return str.length <= 7 ? "Not a valid password!" : null;
                      },
                      onSaved: (str) {
                        _password = str;
                      },
                    ),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: _logIn,
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void _logIn() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        loggedIn = true;
      });

      var snackbar = SnackBar(
        content:
            Text('Username: $_username, Email: $_email, Passord: $_password'),
        duration: Duration(microseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackbar);
    }
  }

  void _logOut() {
    setState(() {
      loggedIn = false;
    });
  }
}
