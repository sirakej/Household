import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/onboarding-screen.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class CandidateCreatedSuccessfully extends StatefulWidget {

  static const String id = 'candidate_created_successfully';

  @override
  _CandidateCreatedSuccessfullyState createState() => _CandidateCreatedSuccessfullyState();
}

class _CandidateCreatedSuccessfullyState extends State<CandidateCreatedSuccessfully> {

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
                'Congratulations! You have been successfully registered as a candidate. Kindly check your mail for notifications on your application update.\n\nThank You',
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
                  Navigator.of(context).pushNamedAndRemoveUntil(OnBoard.id, (Route<dynamic> route) => false);
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  child: Center(
                    child: Text(
                      "Home",
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
            ],
          ),
        ),
      ),
    );
  }

}
