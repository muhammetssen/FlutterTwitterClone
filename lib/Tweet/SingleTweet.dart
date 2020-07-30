import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'SingleTweetPage.dart';

Widget buildTweetTile(tweet, context) {
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
                        image: AssetImage('assets/images/eggIcon.jpg')),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("username"),
                      Text(
                        "jdkdbhdjkdbjdbdjdbdjjdkdbhdjkdbjdbdjdbdjjdkdbhdjkdbjdbdjdbdj",
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
                  color: Colors.grey,
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
                          onPressed: () {}),
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
                          onPressed: () {}),
                    ),
                    Text('  ${tweet['likeCount']}'),
                  ],
                ),
                Transform.scale(
                  scale: 1, //0.7,
                  child: IconButton(
                      icon: Icon(FontAwesomeIcons.shareAlt,
                          color: Color(0xff49494B)),
                      onPressed: () {}),
                ),
              ],
            ),
          ), // tuslar

          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}
