import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

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
        top: false,
        bottom: false,
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight/5,),
              Image.asset("assets/icons/circle check full.png",height:70,width:70,fit: BoxFit.contain,),
              SizedBox(height: 16,),
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
              SizedBox(height: 12,),
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
              SizedBox(height: 82,),
              FlatButton(
                minWidth: SizeConfig.screenWidth,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.only(top:18 ,bottom: 18),
                onPressed:(){
                  /*Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return PickedList();
                      })
                  );*/
                },
                color: Color(0xFF00A69D),
                child: Text(
                  "Proceed",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
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
