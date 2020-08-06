import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:twitter_clone/Tweet/SingleTweet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import '../globals.dart' as globals;

class profilePage extends StatefulWidget {
  var userId;
  profilePage({this.userId});
  @override
  State<StatefulWidget> createState() {
    return _profilePage(userId: this.userId);
  }
}

var globalContext;

class _profilePage extends State<profilePage> {
  var userId;
  Future<Response> getUserData() async {
    return await post(
      globals.serverIP + 'user/getUser',
      body: json.encode({'userId': this.userId}),
      headers: {'content-type': 'application/json'},
    );
  }

  _profilePage({this.userId});
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            return futureProfilePage(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    ;
  }

    var photoSize = 70.0;
    var currentIndex = 0;
    final backgroundColor = Color(0xff000000);
    final blueColor = Color(0xff1BA1F3);
  Widget futureProfilePage(Response res) {
    var user = (json.decode(res.body))['user'];
    // print(user.toString());
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: FloatingActionButton(onPressed: (){Navigator.of(globalContext).pop();}),
        backgroundColor: backgroundColor,
        body: ListView(
          children: <Widget>[
            Container(
              height: 150,
              child: Stack(
                overflow: Overflow.visible,
                fit: StackFit.expand,
                // alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Container(
                    // width: MediaQuery.of(globalContext).size.width,
                    child: Image(
                      image: NetworkImage(
                          'https://pbs.twimg.com/profile_banners/863527548/1465411293/1500x500'),
                    ),
                  ),
                  Positioned(
                      bottom: -photoSize / 2,
                      width: MediaQuery.of(globalContext).size.width,
                      height: photoSize + 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                height: photoSize,
                                width: photoSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(user[
                                        'profilePhoto']), //AssetImage('assets/images/eggIcon.jpg')
                                  ),
                                )),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FlatButton(
                                // color: blueColor,
                                disabledColor: Color(0xff116191),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: blueColor)),
                                onPressed: () => print("pressed"),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(color: blueColor),
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('${user['name']}',style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('@${user['username']}',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis turpis pulvinar, dapibus turpis in, porta ex. Phasellus quis varius dui. Cras nibh dui, placerat in ipsum a, condimentum interdum ante. Cras venenatis justo sit amet arcu tincidunt finibus. In pretium venenatis tortor. Nulla id nulla odio. Donec in elit.",
                        style: TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 13,
                        ),
                        Text("User Location   ",
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Icon(Icons.attach_file, color: Colors.grey, size: 13),
                        InkWell(
                          child: Text("   www.google.com",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 13)),
                          onTap: () async {
                            await launch('http://www.google.com');
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text('${user['followingCount']}',
                          style: TextStyle(fontSize: 12)),
                      Text(
                        '   Following   ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text('${user['followerCount']}',
                          style: TextStyle(fontSize: 12)),
                      Text(
                        '   Followers',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StickyHeader(
              header: Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: currentIndex == 0
                                    ? blueColor
                                    : Colors.grey)),
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Text("Tweets",
                            style: TextStyle(
                                color: currentIndex == 0
                                    ? blueColor
                                    : Colors.grey))),
                    FlatButton(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: currentIndex == 1
                                    ? blueColor
                                    : Colors.grey)),
                        onPressed: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Text("Replies",
                            style: TextStyle(
                                color: currentIndex == 1
                                    ? blueColor
                                    : Colors.grey))),
                    FlatButton(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: currentIndex == 2
                                    ? blueColor
                                    : Colors.grey)),
                        onPressed: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Text("Media",
                            style: TextStyle(
                                color: currentIndex == 2
                                    ? blueColor
                                    : Colors.grey))),
                    FlatButton(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: currentIndex == 3
                                    ? blueColor
                                    : Colors.grey)),
                        onPressed: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        child: Text("Likes",
                            style: TextStyle(
                                color: currentIndex == 3
                                    ? blueColor
                                    : Colors.grey))),
                  ],
                ),
              ),
              content: FutureBuilder(
                  future: getListContent(user['_id'], 'Tweets'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ));
  }

  Future<List<Widget>> getListContent(wantedUserId, type) async {
    var prefs = await SharedPreferences.getInstance();
    Response res = await post(globals.serverIP + 'tweet/get' + type + 'OfUser',
        body: json.encode({
          'wantedUserId': wantedUserId,
          'senderUserId': prefs.getString('user_id')
        }),
        headers: {'content-type': 'application/json'});
    var response = json.decode(res.body);
    // print(response['data'].runtimeType);
    if (response['message'] != "Success") return [Text("Error")];
    List<Widget> posts = (response['data'] as List<dynamic>)
        .map((dynamic item) => buildTweetTile(item, globalContext))
        .toList();
    return posts;
  }
}
