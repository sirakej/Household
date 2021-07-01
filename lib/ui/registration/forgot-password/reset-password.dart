import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sent-link-page.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';

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

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/icons/polygon.png",
                        height: 70,
                        width: 70,
                        fit: BoxFit.contain
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 18, top: 18),
                        child: Image.asset(
                          "assets/icons/reset_password.png",
                          height: 34,
                          width: 34,
                          fit: BoxFit.contain
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gelion',
                      fontSize: 24,
                      color: Color(0xFF57565C),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter the email associated with your account to\nreset your password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF57565C),
                    ),
                  ),
                  SizedBox(height: 42),
                  _buildReset(),
                  SizedBox(height: 38),
                  Button(
                    onTap: (){
                      if(_formKey.currentState.validate() && !_showSpinner){
                        _resetUser();
                      }
                    },
                    buttonColor: Color(0xFF00A69D),
                    child: Center(
                      child: _showSpinner
                          ? CupertinoActivityIndicator(radius: 13)
                          : Text(
                        "Send Instructions",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Center(
                    child: TextButton(
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      child: Text(
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
          SizedBox(height: 10),
          Container(
            width: SizeConfig.screenWidth,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
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

  void _resetUser(){
    if(!mounted) return;
    setState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    api.resetPassword(_emailController.text).then((dynamic) async{
      _emailController.clear();
      if(!mounted) return;
      setState(() { _showSpinner = false; });
      Navigator.push(context,
          CupertinoPageRoute(builder: (_){
            return SentLinkPage(
              email: _emailController.text.toLowerCase().trim(),
            );
          })
      );
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

}
