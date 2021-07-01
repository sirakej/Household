import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/candidate/find-category.dart';
import 'package:householdexecutives_mobile/ui/home/home-screen.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class UserCreatedSuccessfully extends StatefulWidget {

  static const String id = 'user_created_successfully';

  @override
  _UserCreatedSuccessfullyState createState() => _UserCreatedSuccessfullyState();
}

class _UserCreatedSuccessfullyState extends State<UserCreatedSuccessfully> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24, top: 50, right: 24),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/splash_logo.png',
                  width: 152,
                  height:38,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 75),
              Image.asset(
                "assets/icons/circle check full.png",
                height: 70,
                width: 70,
                fit: BoxFit.contain
              ),
              SizedBox(height: 16),
              Text(
                'Account Created!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gelion',
                  fontSize: 19,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Congratulations! You have been successfully\nregistered as a client',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00A69D).withOpacity(0.2), // background
                  onPrimary: Color(0xFF00A69D), // foreground
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Color(0xFF00A69D)),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  shadowColor: Colors.transparent,
                ),
                onPressed:(){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return FindACategory();
                      })
                  );
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  child: Center(
                    child: Text(
                      "Find Candidates",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF00A69D),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: (){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return HomeScreen();
                      })
                  );
                },
                child: Text(
                  "Go Home",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFF00A69D),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
