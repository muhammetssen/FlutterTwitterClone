import 'package:flutter/material.dart';

import 'TweetBottomBar.dart';

class SingleTweetPage extends StatefulWidget {
  final tweet;
  final bottomBar;
  SingleTweetPage({this.tweet, this.bottomBar});
  @override
  State<StatefulWidget> createState() {
    // print(tweet);
    return _SingleTweetPage(tweet, bottomBar);
  }
}

class _SingleTweetPage extends State<SingleTweetPage> {
  final blueColor = Color(0xff1BA1F3);
  final backgroundColor = Color(0xff000000);
  var tweet;
  var bottomBar;
  _SingleTweetPage(tweet, bottomBar) {
    this.tweet = tweet;
    this.bottomBar = bottomBar;
    print(this.bottomBar.toString());
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
                        Text(tweet['User']['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Text(
                          '@${tweet['User']['username']}',
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
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80,
                  child: this.bottomBar.buildPage(),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
