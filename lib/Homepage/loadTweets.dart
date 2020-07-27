import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

String ServerURL = 'http://192.168.1.2:8080/';

Future<List<Widget>> loadTweets() async {
  Response res = await post(ServerURL + 'getAllTweets',
      headers: {'content-type': 'application/json'});
  List<dynamic> response = json.decode(res.body)['message'];
  List<Widget> posts = response
      .map((dynamic item) => ListTile(
            title: Text(item['text'],style: TextStyle(color:Colors.white),),
            // subtitle: Text(item.toString(),style: TextStyle(color:Colors.white),),
          ))
      .toList();

  // 1 tweet 1 chıld 1 widget
  return (posts);
}
