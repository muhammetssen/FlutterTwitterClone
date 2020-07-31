import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SingleTweetPage.dart';

Widget buildTweetTile(tweet, context) {
  // print(tweet['User']['profilePhoto']);
  return ListTile(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleTweetPage(tweet: tweet)));
    },
    subtitle: Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,

                      image: tweet['User']['profilePhoto'] == null
                          ? AssetImage('assets/images/eggIcon.jpg')
                          : NetworkImage(tweet['User'][
                              'profilePhoto']), //AssetImage('assets/images/eggIcon.jpg')
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${tweet['User']['username']}"),
                      Text(
                        '${tweet['text']}',
                        softWrap: true,
                      )
                    ],
                  ),
                ),
              ),
              new Spacer(),
              IconButton(
                alignment: Alignment.topRight,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff49494B),
                ),
                onPressed: () {},
              )
            ],
          ),

          Container(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1, //0.7,
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.comment,
                              color: Color(0xff49494B)),
                          onPressed: () {}),
                    ),
                    Text('  ${tweet['replyCount']}'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1, //0.7,
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.retweet,
                              color: Color(0xff49494B)),
                          onPressed: () async {
                            String ServerURL =
                                'http://192.168.1.2:8080/rttweet';
                            var prefs = await SharedPreferences.getInstance();

                            Response res = await post(ServerURL,
                                headers: {'content-type': 'application/json'},
                                body: jsonEncode({
                                  'tweetId': tweet['_id'],
                                  'userId': prefs.getString('user_id')
                                }));
                          }),
                    ),
                    Text('  ${tweet['retweetCount']}'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1, //0.7,
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.heart,
                              color: Color(0xff49494B)),
                          onPressed: () async {
                            String ServerURL =
                                'http://192.168.1.2:8080/likeTweet';
                            var prefs = await SharedPreferences.getInstance();

                            Response res = await post(ServerURL,
                                headers: {'content-type': 'application/json'},
                                body: jsonEncode({
                                  'tweetId': tweet['_id'],
                                  'userId': prefs.getString('user_id')
                                }));
                          }),
                    ),
                    Text('  ${tweet['likeCount']}'),
                  ],
                ),
                Transform.scale(
                  scale: 1, //0.7,
                  child: IconButton(
                      icon: Icon(Icons.share, color: Color(0xff49494B)),
                      onPressed: () {}),
                ),
              ],
            ),
          ), // tuslar

          Divider(
            color: Colors.grey,
            height: 10,
          ),
        ],
      ),
    ),
  );
}
