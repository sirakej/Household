import 'dart:async';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen_page';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /// Calling [navigate()] before the page loads
  @override
  void initState() {
    super.initState();
   // navigate();
  }

  /// A function to set a 3 seconds timer for my splash screen to show
  /// and navigate to my [welcome] screen after
  void navigate() {
    Timer(
      Duration(seconds: 2),
          () {
        //getBoolValuesSF();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/icons/splash_logo.png',
              width: 192,
              height:48,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
//
//  void getBoolValuesSF() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    bool boolValue = prefs.getBool('loggedIn');
//    if (boolValue == true) {
//      Navigator.of(context).pushReplacementNamed(Index.id);
//    } else if (boolValue == false) {
//      Navigator.of(context).pushReplacementNamed(Sliders.id);
//    } else {
//      Navigator.of(context).pushReplacementNamed(Sliders.id);
//    }
//  }
}