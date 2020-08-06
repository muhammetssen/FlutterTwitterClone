import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Tweet/SingleTweet.dart';
import '../globals.dart' as globals;


Future<List<Widget>> loadTweets(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  Response res = await post(
    globals.serverIP + 'tweet/getAllTweets',
    body: json.encode({'userId': prefs.getString('user_id')}),
    headers: {'content-type': 'application/json'},
  );
  List<dynamic> response = json.decode(res.body)['message'];
  List<Widget> posts =
      (json.decode(res.body)['message'] as List<dynamic>).map((dynamic item) => buildTweetTile(item, context)).toList();

  // 1 tweet 1 chıld 1 widget
  return (posts);
}
