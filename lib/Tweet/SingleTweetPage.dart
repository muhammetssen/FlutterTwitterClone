import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'TweetBottomBar.dart';

class SingleTweetPage extends StatefulWidget {
  var tweet;
  SingleTweetPage({this.tweet});
  @override
  State<StatefulWidget> createState() {
    // print(tweet);
    return _SingleTweetPage(tweet);
  }
}

class _SingleTweetPage extends State<SingleTweetPage> {
  final blueColor = Color(0xff1BA1F3);
  final backgroundColor = Color(0xff000000);
  var tweet;
  _SingleTweetPage(tweet) {
    this.tweet = tweet;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: blueColor),
        title: Text("Thread"),
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: backgroundColor)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 80,
                child: Row(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: tweet['User']['profilePhoto'] == null
                                ? AssetImage('assets/images/eggIcon.jpg')
                                : NetworkImage(tweet['User']['profilePhoto']),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(tweet['User']['name']),
                        Text(
                          tweet['User']['username'],
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  new Spacer(),
                  IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tweet['text'],
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tweet['sentTime'],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                height: 25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('  ${tweet['retweetCount']}'),
                    Text(
                      ' Retweets         ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text('${tweet['likeCount']}'),
                    Text(
                      ' Likes         ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 40,
                  child: buildTweetBottomBar(tweet),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              // ListView(

              // )

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     '${tweet['retweetCount']} Retweets  ${tweet['likeCount']} Likes',
              //     style: TextStyle(color: Colors.grey),),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
