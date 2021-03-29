import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class SignUp extends StatefulWidget {
  static const String id = 'sign_up';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _firstController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _surnameController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _emailController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _mobileController = TextEditingController();

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
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Container(height: 20,),
                      Image.asset("assets/icons/register_logo.png",height:48.46,width:30,fit: BoxFit.contain,),
                      SizedBox(height: 22.54,),
                      Text(
                        'Create An Account!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                          fontSize: 19,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'Register with your account details\nto begin.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          //letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                      SizedBox(height: 43,),
                      _buildSignUp(),
                      SizedBox(height: 44,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){},
                        color: Color(0xFF00A69D),
                        child: Text(
                          "Register Account",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(height: 28,),
                      Center(
                        child: TextButton(
                            onPressed:(){},
                            child:  RichText(
                              text:TextSpan(
                                  text: "Already have an existing account?\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "Login",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFF00A69D),
                                        )
                                    )
                                  ]
                              ),
                              textAlign: TextAlign.center,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: FlatButton(
                        onPressed: null,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Become a candidate today\t",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF00A69D),
                                )
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              size: 18,
                              color: Color(0xFF00A69D),
                            ),
                          ],
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUp() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "First Name",
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
                  controller: _firstController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your First Name';
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
                      hintText: 'Precious',
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
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Surname",
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
                  controller: _surnameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your Surname';
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
                      hintText: 'Surname',
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
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your email address';
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
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mobile Number",
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
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your Mobile Number';
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
                      hintText: '123 4567 890',
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
          SizedBox(height: 20,),
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
                  validator: (value){
                    if(value.isEmpty){
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:(){},
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                    color: Color(0xFF00A69D),
                  ),
                ),
              )
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
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: _condition1 ? Color(0xFF1D1D1D) : Color(0xFFE6E6E6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Minimum of 8 characters',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      color:  _condition2 ? Color(0xFF1D1D1D) : Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color:  _condition2 ? Color(0xFF1D1D1D) : Color(0xFFE6E6E6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'One UPPERCASE character',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      color:  _condition2 ? Color(0xFF1D1D1D) : Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: _condition3 ? Color(0xFF1D1D1D) : Color(0xFFE6E6E6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'One number or unique character',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      color:  _condition2 ? Color(0xFF1D1D1D) : Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              ]
        ),
          SizedBox(height: 28,),
          Row(
            children: [
              RichText(
                text:TextSpan(
                    text: "I agree to the ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF042538),
                    ),
                    children: [
                      TextSpan(
                          text: "Terms & Privacy Policy ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF00A69D),
                          )
                      ),
                      TextSpan(text:" of\nHousehold Executives")
                    ]
                ),
                textAlign: TextAlign.start,
              )
            ],
          )
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
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
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
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E),
            ),
            Container(
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
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
              width: ((SizeConfig.screenWidth - 30) / 3 ) - 2,
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
