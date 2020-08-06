import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class TweetBottomBar {
  var tweet;
  Icon likedIcon = Icon(FontAwesomeIcons.solidHeart, color: Colors.red);
  Icon dislikedIcon = Icon(FontAwesomeIcons.heart, color: Color(0xff49494B));

  Icon retweetIcon = Icon(FontAwesomeIcons.retweet, color: Colors.green);
  Icon notRetweetIcon =
      Icon(FontAwesomeIcons.retweet, color: Color(0xff49494B));
  ValueNotifier<int> likeNotifier;
  ValueNotifier<Icon> likeIconNotifier;
  ValueNotifier<Icon> retweetIconNotifier;
  ValueNotifier<int> retweetNotifier;

  TweetBottomBar(tweet) {
    this.tweet = tweet;
    this.likeNotifier = ValueNotifier(tweet['likeCount']);
    this.likeIconNotifier =
        ValueNotifier(tweet['hasLiked'] ? likedIcon : dislikedIcon);

    this.retweetIconNotifier =
        ValueNotifier(tweet['hasRetweeted'] ? retweetIcon : notRetweetIcon);
    this.retweetNotifier = ValueNotifier(tweet['retweetCount']);
    // print(tweet['User']['profilePhoto']);
  }
  like() {
    likeNotifier.value += 1;
    tweet['hasLiked'] = true;
    likeIconNotifier.value = likedIcon;
  }

  dislike() {
    likeNotifier.value -= 1;
    tweet['hasLiked'] = false;
    likeIconNotifier.value = dislikedIcon;
  }

  retweet() {
    retweetNotifier.value += 1;
    tweet['hasRetweeted'] = true;
    retweetIconNotifier.value = retweetIcon;
  }

  undoRetweet() {
    retweetNotifier.value -= 1;
    tweet['hasRetweeted'] = false;
    retweetIconNotifier.value = notRetweetIcon;
  }

  Widget buildSingle() {
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
                  icon:
                      Icon(FontAwesomeIcons.comment, color: Color(0xff49494B)),
                  onPressed: () {}),
            ),
            Text('${tweet['replyCount']}'),
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
                      this.undoRetweet();
                    } else {
                      this.retweet();
                    }
                    String serverURL = globals.serverIP + 'tweet/rttweet';
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
                      this.dislike();
                    } else {
                      this.like();
                    }
                    String serverURL = globals.serverIP + 'tweet/likeTweet';
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

  Widget buildPage() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 25,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: retweetNotifier,
                builder: (BuildContext context, int newValue, Widget child) {
                  return Text('$newValue  Retweets');
                },
              ),
               ValueListenableBuilder(
              valueListenable: likeNotifier,
              builder: (BuildContext context, int newValue, Widget child) {
                return Text('     $newValue  Likes' );
              },
            ),
            ],
          ),
        ),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.scale(
              scale: 0.8, //0.7,
              child: IconButton(
                  icon:
                      Icon(FontAwesomeIcons.comment, color: Color(0xff49494B)),
                  onPressed: () {}),
            ),
            Transform.scale(
              scale: 0.8, //0.7,
              child: IconButton(
                  icon: ValueListenableBuilder(
                      valueListenable: retweetIconNotifier,
                      builder: (BuildContext context, Icon icon, child) {
                        return icon;
                      }),
                  onPressed: () async {
                    if (tweet['hasRetweeted']) {
                      this.undoRetweet();
                    } else {
                      this.retweet();
                    }
                    String serverURL = globals.serverIP + 'tweet/rttweet';
                    var prefs = await SharedPreferences.getInstance();

                    await post(serverURL,
                        headers: {'content-type': 'application/json'},
                        body: jsonEncode({
                          'tweetId': tweet['_id'],
                          'userId': prefs.getString('user_id')
                        }));
                  }),
            ),
            Transform.scale(
              scale: 0.8, //0.7,
              child: IconButton(
                  icon: ValueListenableBuilder(
                      valueListenable: likeIconNotifier,
                      builder: (BuildContext context, Icon icon, Widget child) {
                        return icon;
                      }),
                  onPressed: () async {
                    // tweetModel.like();
                    if (tweet['hasLiked']) {
                      this.dislike();
                    } else {
                      this.like();
                    }
                    String serverURL = globals.serverIP + 'tweet/likeTweet';
                    var prefs = await SharedPreferences.getInstance();

                    await post(serverURL,
                        headers: {'content-type': 'application/json'},
                        body: jsonEncode({
                          'tweetId': tweet['_id'],
                          'userId': prefs.getString('user_id')
                        }));
                  }),
            ),Transform.scale(
          scale: 0.8, //0.7,
          child: IconButton(
              icon: Icon(Icons.share, color: Color(0xff49494B)),
              onPressed: () {}),
        ),
          ],
        )


      ],
    );
  }
}
