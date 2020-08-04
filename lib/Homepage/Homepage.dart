import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/Images/uploadImage.dart';
import 'package:twitter_clone/Tweet/WriteTweet.dart';
import './loadTweets.dart';
import '../globals.dart' as globals;
import 'Drawer.dart';

var user;

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<Homepage> {
  void getCurrentUser() async {
    var prefs = await SharedPreferences.getInstance();
    Response res = await post(
      globals.serverIP + 'user/getUser',
      body: json.encode({'userId': prefs.getString('user_id')}),
      headers: {'content-type': 'application/json'},
    );
    var response = json.decode(res.body);
    if (response['message'] != "Success") return;
    user = response['user'];
    setState(() {});
  }

  _Homepage() {
    getCurrentUser();
  }
  final backgroundColor = Color(0xff000000);
  final blueColor = Color(0xff1BA1F3);
  var profilePhoto;
  var currentUser;
  String username = '';
  String imagePath;
  Widget _buildAppBar() {
    // if (imagePath == null) loadProfileImage();
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: user == null
                            ? AssetImage('assets/images/eggIcon.jpg')
                            : NetworkImage(user['profilePhoto']),
                      ),
                    )),
              );
            }),
      ),
      backgroundColor: backgroundColor,
      centerTitle:true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Spacer(),
          Icon(
            FontAwesomeIcons.twitter,
            color: blueColor,
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.refresh, color: blueColor), onPressed: _refresh),
        ],
      ),
    );
  }

  loadProfileImage() async {
    var path = (await getApplicationDocumentsDirectory()).path;
    imagePath = path + '/profilePicture.jpg';
  }

  @override
  Widget build(BuildContext context) {
    if (user == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    // loadTweets(context);
    if (imagePath == null) loadProfileImage(); //Use static egg image
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: buildDrawer(user == null ? '' : user),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: backgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: FutureBuilder(
              future: loadTweets(context),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: RefreshIndicator(
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data,
                      ),
                      onRefresh: _refresh,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WriteTweet()));
        },
        child: Icon(
          FontAwesomeIcons.featherAlt,
          color: Colors.white,
          size: 20,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color(0xff000000),
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.home, color: Color(0xff49494B)),
                    onPressed: () {}),
                IconButton(
                    icon:
                        Icon(FontAwesomeIcons.search, color: Color(0xff49494B)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (UploadImage())));
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.bell, color: Color(0xff49494B)),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(FontAwesomeIcons.envelope,
                        color: Color(0xff49494B)),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUsername() async {
    var prefs = await SharedPreferences.getInstance();
    var name = (prefs.getString('username'));
    username = name;
    // setState(() {
    //   username = name;
    // });
  }

  Future<void> _refresh() async {
    setState(() {});
  }
}
