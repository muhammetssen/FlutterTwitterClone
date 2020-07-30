import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './loadTweets.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<Homepage> {
  final backgroundColor = Color(0xff000000);
  final blueColor = Color(0xff1BA1F3);

  String username = '';

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          
          Icon(
            FontAwesomeIcons.twitter,
            color: blueColor,
          ),
          Icon(FontAwesomeIcons.star, color: Colors.black),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (username == '') {
      getUsername();
    }
    // loadTweets(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: backgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FutureBuilder(
              future: loadTweets(context),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data,
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
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
                    onPressed: () {}),
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
}
