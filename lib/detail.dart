import 'package:flutter/material.dart';
import 'waybill.dart';

class DetailScreen extends StatelessWidget {

  final Waybill waybill;
  // In the constructor, require a User
  DetailScreen({Key key, @required this.waybill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(waybill.name),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new ListView.builder(
                    itemCount: waybill.elementStrings.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                          title: Text('${waybill.elementStrings[index].name}' + ": "
                            '${waybill.elementStrings[index].value}')
                      );
                    }
                )
              ),
              new RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                child: Text('Go back!'),
              ),
            ],
          )
        ),
      ),
    );
  }
}