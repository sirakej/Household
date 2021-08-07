import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/schedule-interview.dart';
import 'package:householdexecutives_mobile/ui/home/home-screen.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class SuccessfulPay extends StatefulWidget {

  static const String id = 'successful_pay';

  @override
  _SuccessfulPayState createState() => _SuccessfulPayState();
}

class _SuccessfulPayState extends State<SuccessfulPay> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF050729),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight / 5),
              Image.asset(
                "assets/icons/circle check full.png",
                height: 70,
                width:70,
                fit: BoxFit.contain
              ),
              SizedBox(height: 18.92),
              Text(
                'Payment Successful!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gelion',
                  fontSize: 19,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Thank you for your payment. You may now\nview the reports on your candidates(s)\nand schedule interview date(s)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 48),
              Button(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (_){
                        return HomeScreen();
                      }), (route) => false);
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return ScheduledInterview();
                      }
                      )
                  );
                },
                buttonColor: Color(0xFF00A69D),
                child: Center(
                  child: Text(
                    "Schedule Interview",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gelion',
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (_){
                        return HomeScreen();
                      }), (route) => false);
                },
                child: Text(
                  'Go Home',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
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
