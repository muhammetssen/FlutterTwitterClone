import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../globals.dart' as globals;

class profilePage extends StatefulWidget {
  var userId;
  profilePage({this.userId});
  @override
  State<StatefulWidget> createState() {
    return _profilePage(userId: this.userId);
  }
}

class _profilePage extends State<profilePage> {
  var userId;
  Future<Response> getUserData() async {
    return await post(
      globals.serverIP + 'user/getUser',
      body: json.encode({'userId': this.userId}),
      headers: {'content-type': 'application/json'},
    );
  }

  _profilePage({this.userId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            return futureProfilePage(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    ;
  }
}

Widget futureProfilePage(Response res) {
  final backgroundColor = Color(0xff000000);
  final blueColor = Color(0xff1BA1F3);
  var response = json.decode(res.body);
  return Scaffold(
    backgroundColor: backgroundColor,
    body: Center(child: Container(width: 150,child: Text(response.toString())),),



  );
}
