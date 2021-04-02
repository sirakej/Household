import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:householdexecutives_mobile/ui/onboarding_screen.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen_page';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  /// Calling [navigate()] before the page loads
  ///
  AnimationController _controller;
  Animation _animation;
  bool left = false;
  bool right = false;
  @override
  void initState() {
    super.initState();
   navigate();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds:1),
    );
    //Implement animation here
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  /// A function to set a 3 seconds timer for my splash screen to show
  /// and navigate to my [welcome] screen after
  void navigate() {
    Timer(
      Duration(seconds: 5),
          () {
       Navigator.pushNamed(context, OnBoard.id);
      },
    );
  }

  void time() {
    Timer(
      Duration(milliseconds: 900),
          () {
        setState(() {
          left = right =true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    time();
    //navigate();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: 10,
            left:right == false?100:-50,
            duration: Duration(milliseconds: 250),
            child: Image.asset("assets/icons/blur_right.png", height: 689, width: 689,fit: BoxFit.contain,),
          ),
          AnimatedPositioned(
            top: 0,
            right: left == false ?-100:30,
            duration: Duration(milliseconds: 250),
            child: Image.asset("assets/icons/blur_left.png", height:487, width:487,fit: BoxFit.contain,),
          ),
          FadeTransition(
            opacity: _animation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/splash_logo.png',
                    width: 192,
                    height:48,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height:17),
                  Text(
                    "Good help is no longer so hard to find",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      color: Color(0xFF717F88),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: SizeConfig.screenWidth/2,
            child: Center(
              child: FadeTransition(
                opacity: _animation,
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              ),
            ),
          )
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