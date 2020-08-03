import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

Widget buildTweetBottomBar(tweet) {
  ValueNotifier<int> likeNotifier = ValueNotifier(tweet['likeCount']);
  Icon likedIcon = Icon(FontAwesomeIcons.solidHeart, color: Colors.red);
  Icon dislikedIcon = Icon(FontAwesomeIcons.heart, color: Color(0xff49494B));
  ValueNotifier<Icon> likeIconNotifier =
      ValueNotifier(tweet['hasLiked'] ? likedIcon : dislikedIcon);

  Icon retweetIcon = Icon(FontAwesomeIcons.retweet, color: Colors.green);
  Icon notRetweetIcon =
      Icon(FontAwesomeIcons.retweet, color: Color(0xff49494B));
      
  ValueNotifier<Icon> retweetIconNotifier =
      ValueNotifier(tweet['hasRetweeted'] ? retweetIcon : notRetweetIcon);
  ValueNotifier<int> retweetNotifier = ValueNotifier(tweet['retweetCount']);
  // print(tweet['User']['profilePhoto']);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Transform.scale(
            scale: 1, //0.7,
            child: IconButton(
                icon: Icon(FontAwesomeIcons.comment, color: Color(0xff49494B)),
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
                icon: ValueListenableBuilder(
                    valueListenable: retweetIconNotifier,
                    builder: (BuildContext context, Icon icon, child) {
                      return icon;
                    }),
                onPressed: () async {
                  if (tweet['hasRetweeted']) {
                    retweetNotifier.value -= 1;
                    tweet['hasRetweeted'] = false;
                    retweetIconNotifier.value = notRetweetIcon;
                  } else {
                    retweetNotifier.value += 1;
                    tweet['hasRetweeted'] = true;
                    retweetIconNotifier.value = retweetIcon;
                  }
                  String serverURL = globals.serverIP+'rttweet';
                  var prefs = await SharedPreferences.getInstance();

                   await post(serverURL,
                      headers: {'content-type': 'application/json'},
                      body: jsonEncode({
                        'tweetId': tweet['_id'],
                        'userId': prefs.getString('user_id')
                      }));
                }),
          ),
          ValueListenableBuilder(
            valueListenable: retweetNotifier,
            builder: (BuildContext context, int newValue, Widget child) {
              return Text('$newValue');
            },
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Transform.scale(
            scale: 1, //0.7,
            child: IconButton(
                icon: ValueListenableBuilder(
                    valueListenable: likeIconNotifier,
                    builder: (BuildContext context, Icon icon, Widget child) {
                      return icon;
                    }),
                onPressed: () async {
                  // tweetModel.like();
                  if (tweet['hasLiked']) {
                    likeNotifier.value -= 1;
                    tweet['hasLiked'] = false;
                    likeIconNotifier.value = dislikedIcon;
                  } else {
                    likeNotifier.value += 1;
                    tweet['hasLiked'] = true;
                    likeIconNotifier.value = likedIcon;
                  }
                  String serverURL = globals.serverIP+'likeTweet';
                  var prefs = await SharedPreferences.getInstance();

                   await post(serverURL,
                      headers: {'content-type': 'application/json'},
                      body: jsonEncode({
                        'tweetId': tweet['_id'],
                        'userId': prefs.getString('user_id')
                      }));
                }),
          ),
          ValueListenableBuilder(
            valueListenable: likeNotifier,
            builder: (BuildContext context, int newValue, Widget child) {
              return Text('$newValue');
            },
          ),
          // Text('  ${tweetModel.likeCount}')
          // Text('  ${tweet['likeCount']}'),
        ],
      ),
      Transform.scale(
        scale: 1, //0.7,
        child: IconButton(
            icon: Icon(Icons.share, color: Color(0xff49494B)),
            onPressed: () {}),
      ),
    ],
  );
}
