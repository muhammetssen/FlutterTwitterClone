import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;
class WriteTweet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WriteTweet();
  }
}

class _WriteTweet extends State<WriteTweet> {
  final backgroundColor = Color(0xff000000);
  final blueColor = Color(0xff1BA1F3);
  bool isTooLong = false;
  var tweetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    tweetController.addListener(() {
      setState(() {
        isTooLong = false;
        if (tweetController.text.length > 280) isTooLong = true;
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.times,
              size: 20,
              color: blueColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FlatButton(
                color: blueColor,
                disabledColor: Color(0xff116191),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide()),
                onPressed: isTooLong ? null : _sendTweet,
                child: Text(
                  "Tweet",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/eggIcon.jpg'),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: tweetController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: backgroundColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: backgroundColor)),
                        hintText: "What's happening?",
                        hintStyle:
                            TextStyle(color: Color(0xff717576), fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              child: Container(
                color: backgroundColor,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.image,
                        color: blueColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.gift,
                        color: blueColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.archive,
                        color: blueColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: blueColor,
                      ),
                      onPressed: () {},
                    ),
                    new Spacer(),
                    Container(
                        height: 23,
                        width: 23.0,
                        child: isTooLong
                            ? Text('${280 - tweetController.text.length}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))
                            : CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    isTooLong ? Colors.red : blueColor),
                                strokeWidth: 2,
                                value: tweetController.text.length / 280,
                              )),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        color: blueColor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _sendTweet() async {
    var tweet = {};
    tweet['full_text'] = tweetController.text;
    var prefs = await SharedPreferences.getInstance();
    tweet['_id'] = prefs.getString('user_id');
    await post(
      globals.serverIP+'tweet/createTweet',
      body: jsonEncode(tweet),
      headers: {'content-type': 'application/json'},
    );
    Navigator.pop(context);
  }
}
