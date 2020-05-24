import 'package:flutter/material.dart';
import 'package:splttr/pages/friends/groups.dart';
import 'package:splttr/pages/friends/view_group.dart';
import 'package:splttr/res/colors.dart';
import 'package:splttr/pages/login/signin.dart';
import 'package:splttr/pages/login/signup.dart';
import 'package:splttr/pages/appscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'splttr',
      theme: ThemeData(
        primaryColor: PurpleTheme.darkPurple,
        scaffoldBackgroundColor: Colors.white, // Color(0xFF393073)
        accentColor: PurpleTheme.pinkishPurple,
        canvasColor: PurpleTheme.blue,
        textTheme:
            Theme.of(context).textTheme.apply(fontFamily: 'Merriweather'),
      ),
      // home: AddSplit(),
      initialRoute: '/groups',
      routes: {
        '/': (context) => SigninScreen(),
        '/home': (context) => AppScreen(),
        '/signup': (context) => SignupScreen(),
        '/groups':(context) => ViewGroup(),
      },
    );
  }
}
