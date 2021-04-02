import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/create_new_password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/reset_password.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class SentLinkPage extends StatefulWidget {
  static const String id = 'sent_link';
  @override
  _SentLinkPageState createState() => _SentLinkPageState();
}

class _SentLinkPageState extends State<SentLinkPage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight/9,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/create_new_password.png",height:112,width:112,fit: BoxFit.contain,),
                      SizedBox(height: 23,),
                      Text(
                        'Check your mail',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                          fontSize: 19,
                          color: Color(0xFF57565C),
                        ),
                      ),
                      SizedBox(height: 12,),
                      RichText(
                        text:TextSpan(
                            text: "We have sent a link to ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF57565C),
                            ),
                            children: [
                              TextSpan(
                                  text: "pre*******@mail.com\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF57565C),
                                  )
                              ),
                              TextSpan(text:"for your account recover",),
                            ]
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 59,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_){
                                return CreateNewPassword();
                              })
                          );
                        },
                        color: Color(0xFF00A69D),
                        child: Text(
                          "Open email app",
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
                SizedBox(height: 120,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Did not receive the email ? Check your spam folder",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "or ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF57565C),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (_){
                                    return Reset();
                                  })
                              );
                            },
                            child: Text(
                              "try another email address",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF00A69D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
