import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/User/profilePage.dart';
import 'TweetBottomBar.dart';
import 'SingleTweetPage.dart';
import '../globals.dart' as globals;

Widget buildTweetTile(tweet, context) {
  Color greyColor = Color(0xff49494B);

  TweetBottomBar bar = new TweetBottomBar(tweet);
  Widget bottomBar = bar.buildSingle();
  return ListTile(
    onTap: () async {
      var prefs = await SharedPreferences.getInstance();
      Response res = await post(
        globals.serverIP + "tweet/getTweet",
        body: json.encode(
            {'tweetId': tweet['_id'], 'userId': prefs.getString('user_id')}),
        headers: {'content-type': 'application/json'},
      );
      var singleTweet = json.decode(res.body)['tweet'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleTweetPage(tweet: singleTweet,bottomBar: bar,)));
    },
    subtitle: Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               Builder(builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(userId:tweet['User']['_id'])));
                },
                child: Container(
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
              );
            }),
              
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                      Text("${tweet['User']['name']} ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("@${tweet['User']['username']}",style: TextStyle(color: greyColor),),

                      ],),
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
            child: bottomBar,
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
