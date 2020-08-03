import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage/Homepage.dart';
import 'LogIn/LogInPage.dart';
import 'LogIn/SignUpPage1.dart';

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
  String selectedInitialRoute = '/';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            // Navigator.popUntil(context, ModalRoute.withName('/homepage'));
            selectedInitialRoute = '/homepage';
          } else {
            selectedInitialRoute = '/logInPage';
          }
          // print("Selected route: $selectedInitialRoute");
          return MaterialApp(
            // home: BaseApp(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white
              )
            ),

            initialRoute: selectedInitialRoute,
            // initialRoute :'/signUpPage2',
            routes: <String, WidgetBuilder>{
              // '/': (context) => CircularProgressIndicator(),
              '/logInPage': (context) => LogInPage(),
              '/signUpPage1': (context) => SignUpPage1(),
              // '/signUpPage2': (context) => SignUpPage2(),
              '/homepage': (context) => Homepage(),
            },
          );
        }
        return Center(child: (CircularProgressIndicator()));
      },
    );
  }
}
