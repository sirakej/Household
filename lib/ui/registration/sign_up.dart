import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/ui/registration/register_candidate.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_in.dart';
import 'package:householdexecutives_mobile/ui/registration/user_created_successfully.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  bool isCheck = false;

  /// A boolean variable to control showing of the progress indicator
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
             Expanded(
               child: SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     _buildSignUp(),
                     SizedBox(height: 44,),
                     FlatButton(
                       minWidth: SizeConfig.screenWidth,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8)
                       ),
                       padding: EdgeInsets.only(top:18 ,bottom: 18),
                       onPressed:(){
                         if(isCheck){
                           if(_formKey.currentState.validate()){
                             if(_passwordValidated){
                               _signUp();
                             }
                           }
                         }
                         else {
                           Constants.showError(context, 'Agree to our terms and conditions');
                         }
                       },
                       color: Color(0xFF00A69D),
                       child:  _showSpinner
                           ? CupertinoActivityIndicator(radius: 13)
                           :Text(
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
                           onPressed:(){
                             Navigator.push(context,
                                 CupertinoPageRoute(builder: (_){
                                   return SignIn();
                                 })
                             );
                           },
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
                     Container(
                       alignment: Alignment.center,
                       child: Center(
                         child: TextButton(
                             onPressed: (){
                               Navigator.pushNamed(context, RegisterCandidate.id);
                             },
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                     "Become A Candidate Today\t",
                                     style: TextStyle(
                                       fontWeight: FontWeight.w400,
                                       fontFamily: 'Gelion',
                                       fontSize: 14,
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
             )
            ],
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
                    if (value.length < 3){
                      return 'Firstname should be at least 3 characters';
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
                    if (value.length < 3){
                      return 'Surname should be at least 3 characters';
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your email';
                    }
                    if (value.length < 3 && !value.contains("@") && !value.contains(".")){
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
                    if(value.isEmpty ){
                      return 'Enter your Mobile Number';
                    }
                    if(value.length < 11 || value.length > 11){
                      return 'incorrect mobile number';
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
                      hintText: '',
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
                  onChanged: (value){
                    setState(() {
                      _password = _passwordController.text;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your password';
                    }
                    if(_condition1 == false){
                      Constants.showError(context, "password must be at least 8 characters long");
                    }if(_condition2 == false){
                      Constants.showError(context, "password needs to include upper case character");
                    }if(_condition3 == false){
                      Constants.showError(context, "password needs to include a number or unique character");
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
          SizedBox(height: 28,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: isCheck == false
                      ? Icon(
                    Icons.check_box_outline_blank_outlined,
                    size: 25,
                    color:  Color(0xFF9097A5),
                  )
                      : Icon(
                    Icons.check_box_outlined,
                    size: 25,
                    color:  Color(0xFF9097A5),
                  ),
                  onPressed: (){
                    setState(() {
                      isCheck =! isCheck;
                    });
                  }
              ),
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
            Expanded(
              child: AnimatedContainer(
                width: SizeConfig.screenWidth,
                height: 4,
                color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
              ),
            ),
            Expanded( 
              child: AnimatedContainer( 
                width: SizeConfig.screenWidth,
                height: 4,
                color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                width: SizeConfig.screenWidth,
                height: 4,
                color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
              ),
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
            AnimatedContainer(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
            ),
            AnimatedContainer(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
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
            AnimatedContainer(
              width: ((SizeConfig.screenWidth - 30) / 3.1 ) - 2,
              height: 4,
              color: Color(0xFFFA9E3E), duration:  Duration(milliseconds: 700),
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

  /// Function that creates a new user by calling
  /// [signUp] in the [AuthRestDataSource] class
  void _signUp(){
    if(!mounted)return;
    setState(() {
      _showSpinner = true;
    });
    var api = AuthRestDataSource();
    api.signUp(_firstController.text,_surnameController.text, _emailController.text,_mobileController.text, _passwordController.text).then((User user)async {
      _firstController.clear();
      _surnameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _passwordController.clear();
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
      });
      var db=DatabaseHelper();
      await db.initDb();
      await db.saveUser(user);
      _addBoolToSF(true,user);
    }).catchError((e){
      print(e);
      _passwordController.clear();
      if (!mounted) return;
      setState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

  /// This function adds a [state] boolean value to the device
  /// [SharedPreferences] logged in
  _addBoolToSF(bool state, User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', state);
    Navigator.pushNamedAndRemoveUntil(context, UserCreatedSuccessfully.id, (route) => false);

  }

}
