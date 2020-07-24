import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogInPage();
  }
}

class _LogInPage extends State<LogInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final blueColor = Color(0xff1BA1F3);
  final backgroundColor = Color(0xff000000);
  Widget _buildAppbar() {
    return AppBar(
      leading: BackButton(color: blueColor),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, '/signUpPage'),
          child: Text(
            "Sign up",
            style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => print("Three dots"),
          color: blueColor,
        ),
      ],
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.twitter,
            color: blueColor,
          )
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Log in")),
      appBar: _buildAppbar(),
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: backgroundColor),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Log in to Twitter.",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Phone, email or username",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color(0xff717576),
                      fontSize: 12.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  height: 25.0,
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor, width: 2.0)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff151515), width: 2.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Password",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color(0xff717576),
                      fontSize: 12.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  height: 25.0,
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor, width: 2.0)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff151515), width: 2.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.00,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => print("Forgotten Password"),
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color(0xff717576),
                            fontSize: 10.0,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
