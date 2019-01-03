import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'waybill.dart';
import 'detail.dart';
import 'dart:async';
import 'dart:convert';

Future<List<Waybill>> fetchPost() async {
  http.Response response =
  await http.get('http://localhost:3000/waybills');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Waybill.fromJson(m)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class HistoryScreen extends StatelessWidget {
  final User user;

  // In the constructor, require a User
  HistoryScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(user.username),
        ),
        body: Center(
          child: FutureBuilder<List<Waybill>>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              List<Waybill> waybills = snapshot.data;
              return new ListView.builder(
                  itemCount: waybills == null ? 0 : waybills.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      child: new Center(
                          child: new Column(
                            // Stretch the cards in horizontal axis
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new Card(
                                child: new Column(
                                  children: <Widget>[
                                    new ListTile(
                                      title: Text(waybills[index].name),
                                      subtitle: Text(waybills[index].elementStrings[0].name),
                                    ),
                                    ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                      child: ButtonBar(
                                        children: <Widget>[
                                          FlatButton(
                                            child: const Text('DETAILS'),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => DetailScreen()),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                            ],
                          )),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
