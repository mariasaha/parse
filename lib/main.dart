import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  print(_data[0]['title']);
  String _body = "";

  for (int i = 0; i< _data.length; i++) {
    print("Title:   ${_data[i]['title']}");
    print("Body:    ${_data[i]['body']}");
  }
  _body = _data[0]['body'];

  runApp(MaterialApp(
    home: new Scaffold(
      appBar:  new AppBar(
        title: new Text('JSON Parse with Flutter'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return new Divider();
            //divide position by 2 to return an integer result.
              final index = position ~/2;
            return new Column(
              children: <Widget>[
                new Divider(height:5.5),
                new ListTile(
                  title: Text("${_data[index]['title']}",
                  style: new TextStyle(fontSize: 17.9),),
                    subtitle: Text("${_data[index]['body']}",
                      style: new TextStyle(fontSize: 14.9,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic)),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text("${_data[position]['body'][0]}".toUpperCase(),
                    style: new TextStyle(
                        fontSize: 16.4,
                        color: Colors.orangeAccent),
                    ),
                  ),
                  //onTap: () => print("${_data[position]['id']}"),
                  onTap:(){ _showOnTapMessage(context, "${_data[index]['title']}");}
                  //onTap: ()=> debugPrint("$index"),
                )
              ]
            );
          },
        )
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: Text("My App"),
    content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
  );
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiURL = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
}
