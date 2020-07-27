import 'package:flutter/material.dart';
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

  String username = '';

  Widget _buildAppBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          Text(
            "appbar",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (username == '') {
      getUsername();
    }
    loadTweets();
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
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: loadTweets(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  print("income");
                  return Container(
                    height: 400,
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
          child: Row(),
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
