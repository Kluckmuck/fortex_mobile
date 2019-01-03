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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  var user = new User('','');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child:           new Container(
              child: new TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your username';
                  }
                },
                decoration: new InputDecoration(
                    labelText: 'Username'
                ),
              ),
            ),
          ),
          Padding(
          padding: EdgeInsets.all(8.0),
          child: new Container(
            child: new TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your password';
                }
              },
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
                _loginPOST();
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _loginPOST () {
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
            print("print false");
            //TODO: Show error in APP
          }
      //print("Response status: ${response.statusCode}");
    });
  }
}

