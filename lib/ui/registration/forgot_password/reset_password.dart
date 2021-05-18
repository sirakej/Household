import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/sent_link_page.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class Reset extends StatefulWidget {
  static const String id = 'reset';
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _emailController = TextEditingController();


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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 70,),
                      Image.asset("assets/icons/reset_password.png",height:34,width:34,fit: BoxFit.contain,),
                      SizedBox(height: 36,),
                      Text(
                        'Reset Password',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                          fontSize: 24,
                          color: Color(0xFF57565C),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'Enter the email associated with your account to\nreset your password',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          //letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),

                      SizedBox(height: 42,),
                        _buildReset(),
                      SizedBox(height: 38,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_){
                                return SentLinkPage();
                              })
                          );
                        },
                        color: Color(0xFF00A69D),
                        child: Text(
                          "Send Instructions",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(height: 22,),
                      Center(
                        child: TextButton(
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            child:  Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF717F88),
                                )
                            )
                        ),
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

  Widget _buildReset() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email Address",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Gelion',
              fontSize: 14,
              color: Color(0xFF042538),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: SizeConfig.screenWidth,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your email';
                }
                if (value.length < 3 || !value.contains("@") || !value.contains(".")){
                  return 'Invalid email address';
                }
                return null;
              },
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                color: Color(0xFF042538),
              ),
              decoration:kFieldDecoration.copyWith(
                  hintText: 'placeholder@mail.com',
                  hintStyle:TextStyle(
                    color:Color(0xFF717F88),
                    fontSize: 14,
                    fontFamily: 'Gelion',
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
