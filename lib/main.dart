import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'history.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fortex App',
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  var user = new User('','');

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      user.username = "";
    } else {
      user.username = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      user.password = "";
    } else {
      user.password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Fortex Login"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  labelText: 'Username'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new RaisedButton(
            child: new Text('Login'),
            onPressed: _loginPressed,
          ),
        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () {
    var url = "http://localhost:3000/login";
    http.post(url, body: user.toJson())
        .then((response) {
          if (response.statusCode == 201) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryScreen()),
            );
            //print("Response body: ${response.body}");
          }
          else {
            //TODO: Show error in APP
          }
      //print("Response status: ${response.statusCode}");
    });
  }
}

