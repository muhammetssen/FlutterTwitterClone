import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final backgroundColor = Color(0xff000000);
final blueColor = Color(0xff1BA1F3);
Widget buildDrawer(user) {
  if (user == '') return CircularProgressIndicator();
  Color greyColor = Color(0xff49494B);
  return Drawer(
      child: Stack(
    children: <Widget>[
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: backgroundColor),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: user == null
                            ? AssetImage('assets/images/eggIcon.jpg')
                            : NetworkImage(user['profilePhoto']),

                        // AssetImage(imagePath != null
                        //     ? imagePath
                        //     : 'assets/images/eggIcon.jpg'), //AssetImage('assets/images/eggIcon.jpg'),
                      ),
                    )),
                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${user['name']}'),
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: blueColor,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Text(
                  '@${user['username']}', // tweet['User']['username'],
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Text('${user['followingCount']}'),
                      Text(
                        '   Following   ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('${user['followerCount']}'),
                      Text(
                        '   Followers',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(FontAwesomeIcons.user, color: greyColor),
                    ),
                    Padding(
                      
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Profile",
                        
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(FontAwesomeIcons.listAlt, color: greyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Lists",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child:
                          Icon(FontAwesomeIcons.rocketchat, color: greyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Topics",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(Icons.bookmark_border, color: greyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Bookmarks",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 30.0, bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(FontAwesomeIcons.bolt, color: greyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Moments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: greyColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(FontAwesomeIcons.ad, color: greyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Twitter Ads",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: greyColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Setting and privacy",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Help Center",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Positioned(
          bottom: 15,
          right: 0,
          left: 0,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: greyColor)),
            ),
            // width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(FontAwesomeIcons.lightbulb, color: blueColor),
                Icon(FontAwesomeIcons.qrcode, color: blueColor),
              ],
            ),
          ))
    ],
  ));
}
