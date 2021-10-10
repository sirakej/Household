import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:householdexecutives_mobile/notifications/notification-manager.dart';
import 'package:householdexecutives_mobile/ui/home/home-screen.dart';
import 'package:householdexecutives_mobile/ui/onboarding-screen.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen_page';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  /// Calling [navigate()] before the page loads
  AnimationController _controller;

  Animation _animation;

  bool left = false;

  bool right = false;

  void _checkVersion() async {
    final newVersion = NewVersion(
        androidId: 'com.household.executives',
        iOSId: 'com.householdexecutives.io'
    );
    await newVersion.getVersionStatus().then((status) {
      if(status.canUpdate){
        newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogTitle: 'Household Executives',
            dialogText: 'New update is available, you can update to the latest version \n ${status.storeVersion}',
            dismissAction: (){
              Navigator.pop(context);
              _navigate();
            },
            updateButtonText: 'Open ${Platform.isIOS ? 'App Store' : 'Play Store'}'
        );
      }
      else {
        _navigate();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _navigate();
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
    _controller?.dispose();
    super.dispose();
  }

  /// A function to set a 3 seconds timer for my splash screen to show
  /// and navigate to my [OnBoard] screen after
  void _navigate() {
    Timer(Duration(seconds: 2), () { getBoolValuesSF(); });
  }

  void time() {
    Timer(
      Duration(milliseconds: 900),
          () {
        if(!mounted)return;
        setState(() {
          left = right = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    time();
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
                    'assets/icons/splash_head_logo.png',
                    width:28.69,
                    height:47.54,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/icons/frame_logo.png',
                    width: 192,
                    height:48,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height:17),
                  Text(
                    "Good Help Better Life",
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

  void getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('loggedIn');
    NotificationManager notificationManager = NotificationManager();
    await notificationManager.configurePendingInterviewNotifications();
    if (boolValue == true) {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (_){
            return HomeScreen();
          })
      );
    }
    else if (boolValue == false) {
      Navigator.of(context).pushReplacementNamed(OnBoard.id);
    }
    else {
      Navigator.of(context).pushReplacementNamed(OnBoard.id);
    }
  }
}