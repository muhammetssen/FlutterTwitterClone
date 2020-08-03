import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

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

  double greyFontSize = 20;
  double whiteFontSize = 25;

  bool isFormDone = false;
  bool showPassword = false;
  changeFormDone(isActive) {
    setState(() {
      isFormDone = isActive;
    });
  }

  Widget _buildAppbar() {
    return AppBar(
      leading: BackButton(color: blueColor),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, '/signUpPage1'),
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
    passwordController.addListener(() {
      changeFormDone(passwordController.text.length >= 8 &&
          usernameController.text.length != 0);
    });
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
                      fontSize: whiteFontSize,
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
                      fontSize: greyFontSize,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  child: TextField(
                    controller: usernameController,
                    style: TextStyle(
                        fontSize: whiteFontSize - 3, color: Colors.white),
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
                      fontSize: greyFontSize,
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    style: TextStyle(
                        fontSize: whiteFontSize - 3, color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          }),
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
                            fontSize: greyFontSize - 5,
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color(0xff000000),
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  color: blueColor,
                  disabledColor: Color(0xff116191),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide()),
                  onPressed: isFormDone ? _logIn : null,
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _logIn() async {
    Map<String, String> credentials = {};
    if (usernameController.text.contains('@')) {
      credentials['email'] = usernameController.text;
    } else {
      credentials['username'] = usernameController.text;
    }
    credentials['password'] = passwordController.text;

    Response res = await post(globals.serverIP + 'logIn',
        headers: {'content-type': 'application/json'},
        body: jsonEncode(credentials));
    var status = (json.decode(res.body));
    if (status['message'] == 'Success') {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('username', credentials['username']);
      prefs.setString('user_id', status['_id']);
      prefs.setBool('isLoggedIn', true);
      // print(status['_id']);

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage', (Route<dynamic> route) => false);

      // Navigator.popAndPushNamed(context, '/homepage');

    } else {
      Fluttertoast.showToast(
          msg: status['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xff33828282),
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }
}
