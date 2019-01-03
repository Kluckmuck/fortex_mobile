import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'waybill.dart';
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
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Waybill>>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              List<Waybill> posts = snapshot.data;
              return new ListView(
                children: posts.map((post) => Text(post.name)).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
