import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_in.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class CreateNewPassword extends StatefulWidget {
  static const String id = 'create_new_password';
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();


  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _passwordController = TextEditingController();

  /// A boolean variable to hold whether the password should be shown or hidden
  bool _obscureTextLogin = true;

  /// A boolean value holing true or false if the first validation rule is satisfied for password input
  bool _condition1 = false;

  /// A boolean value holing true or false if the second validation rule is satisfied for password input
  bool _condition2 = false;

  /// A boolean value holing true or false if the third validation rule is satisfied for password input
  bool _condition3 = false;

  /// A boolean variable to hold the password if it is validated or not
  bool _passwordValidated = false;

  /// A string variable holding the password
  String _password = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70,),
                      Image.asset("assets/icons/create_new_password.png",height:70,width:70,fit: BoxFit.contain,),
                      SizedBox(height: 8,),
                      Text(
                        'Create New Password',
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
                        'Your new password must be different from\nprevious used passwords.',
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
                      _buildCreateNewPassword(),
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
                                return SignIn();
                              })
                          );
                        },
                        color: Color(0xFF00A69D),
                        child: Text(
                          "Reset Password",
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
          ]
        ),
      ),
    )
      )
    );
  }

  Widget _buildCreateNewPassword() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
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
                      obscureText: _obscureTextLogin,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value){
                        setState(() {
                          _password = _passwordController.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your password';
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
                          suffixIcon: TextButton(
                            onPressed:_toggleLogin,
                            child:_obscureTextLogin ?
                            Text(
                              "show",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF042538),
                              ),
                            ): Text(
                              "Hide",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF042538),
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _conditionsPassed(),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          child: _condition1 == false ? Icon(
                            Icons.circle,
                            color: Color(0xFF9097A5),
                            size: 12,
                          ):Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Color(0xFF00A69D),),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Minimum of 8 characters',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Gelion',
                            color:Color(0xFF717F88),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          child: _condition2 == false ? Icon(
                            Icons.circle,
                            color: Color(0xFF9097A5),
                            size: 12,
                          ):Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Color(0xFF00A69D),),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'One UPPERCASE character',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Gelion',
                            color: Color(0xFF717F88),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          child: _condition3 == false ? Icon(
                            Icons.circle,
                            color: Color(0xFF9097A5),
                            size: 12,
                          ):Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Color(0xFF00A69D),),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'One number or unique character',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Gelion',
                            color:Color(0xFF717F88),
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ]
        )
    );
  }

  /// A function to toggle if to show the password or not by
  /// changing [_obscureTextLogin] value
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
  /// Function to build the widget of conditions passed
  /// Function to build the widget of conditions passed
  Widget _conditionsPassed(){
    bool two = _condition2 = (_password.contains(RegExp(r'[A-Z]'))  && _password.contains(RegExp(r'[a-z]')));
    bool one = _condition1 = _password.length > 8;
    bool three = _condition3 = (_password.contains(RegExp(r'[0-9]'))  || _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')));

    if(one && two && three){
      setState(() {
        _passwordValidated = true;
      });
      return Container(
        width: SizeConfig.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
          ],
        ),
      );
    }
    else if((one && two) || (one && three) || (two && three)){
      setState(() {
        _passwordValidated = false;
      });
      return Container(
        width: SizeConfig.screenWidth,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
          ],
        ),
      );
    }
    else if(one || two || three){
      setState(() {
        _passwordValidated = false;
      });
      return Container(
        width: SizeConfig.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
          ],
        ),
      );
    }
    else {
      setState(() {
        _passwordValidated = false;
      });
      return Container();
    }
  }
}
