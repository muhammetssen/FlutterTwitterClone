import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/User/userModel.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../globals.dart' as globals;

class SignUpPage2 extends StatefulWidget {
  final User user;
  SignUpPage2({Key key, @required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SignUpPage2(user: this.user);
  }
}

class _SignUpPage2 extends State<SignUpPage2> {
  User user;

  _SignUpPage2({@required this.user});

  String email = '';
  String dateOfBirth = '';
  final blueColor = Color(0xff1BA1F3);
  final backgroundColor = Color(0xff000000);
  final inputTextColor = Colors.white;

  double greyFontSize = 18;
  double whiteFontSize = 25;

  bool showPassword = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool isUserNameApproved = true;
  bool isPasswordApproved = true;

  bool isPasswordDone = false, isUserNameDone = true, isFormDone = false;
  Widget _buildAppbar() {
    return AppBar(
      leading: BackButton(color: blueColor),
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

  void checkPassword() {
    setState(() {
      String entered = passwordController.text;
      isPasswordApproved = true;
      if (entered.length < 8) {
        isPasswordApproved = false;
      }
      if (entered != rePasswordController.text) {
        isPasswordApproved = false;
      }
      isPasswordDone = isPasswordApproved;
    });
  }

  @override
  Widget build(BuildContext context) {
    isFormDone = isUserNameDone && isPasswordDone;
    passwordController.addListener(() {
      checkPassword();
    });
    rePasswordController.addListener(() {
      checkPassword();
      if (rePasswordController.text != passwordController.text) {
        setState(() {
          isPasswordApproved = false;
        });
      }
    });

    return Scaffold(
        appBar: _buildAppbar(),
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: backgroundColor)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Create your account",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: whiteFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 45.0,
                        child: TextField(
                          controller: usernameController,
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: blueColor, width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff151515), width: 2.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45.0,
                        child: TextField(
                          controller: passwordController,
                          maxLines: 1,
                          obscureText: !showPassword,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
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
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isPasswordApproved
                                        ? blueColor
                                        : Colors.red,
                                    width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isPasswordApproved
                                        ? Color(0xff151515)
                                        : Colors.red,
                                    width: 2.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45.0,
                        child: TextField(
                          controller: rePasswordController,
                          maxLines: 1,
                          obscureText: !showPassword,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Re-enter the password",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isPasswordApproved
                                        ? blueColor
                                        : Colors.red,
                                    width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isPasswordApproved
                                        ? Color(0xff151515)
                                        : Colors.red,
                                    width: 2.0)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          // color: Colors.green,
          child: Container(
            color: Color(0xff000000),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      color: blueColor,
                      disabledColor: Color(0xff116191),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide()),
                      onPressed: isFormDone
                          ? _nextPage
                          : null, //() => print("pressed"),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  void _nextPage() async {
    this.user.username = usernameController.text;
    this.user.password = passwordController.text;
    Response res = await post(
      globals.serverIP+'user/createAccount',
        body: jsonEncode(this.user.returnAsDict()),
        headers: {'content-type': 'application/json'});
    var status = (json.decode(res.body));
    if (status['message'] == 'Success') {
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      // Navigator.pushNamed(context, '/homepage');
      prefs.setString('user_id', status['_id']);

      prefs.setString('username', this.user.username);
      print(status['_id']);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage', (Route<dynamic> route) => false);
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
