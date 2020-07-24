import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LogIn/LogInPage.dart';
import 'LogIn/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

Future<bool> isLoggedIn() async {
  var prefs = await SharedPreferences.getInstance();
  bool a = prefs.getBool("isLoggedIn");
  if (a == null) {
    prefs.setBool('isLoggedIn', false);
    return isLoggedIn();
  }
  return prefs.getBool("isLoggedIn");
}

class _MyApp extends State<MyApp> {
  String selectedInitialRoute = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            selectedInitialRoute = '/homePage';
          } else {
            selectedInitialRoute = '/logInPage';
          }
          return MaterialApp(
            // home: BaseApp(),
            debugShowCheckedModeBanner: false,

            initialRoute: selectedInitialRoute,
            routes: <String, WidgetBuilder>{
              '/logInPage': (context) => LogInPage(),
              '/signUpPage': (context) => SignUpPage(),
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
