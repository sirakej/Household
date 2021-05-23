import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/ui/home/home_screen.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_up.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password/reset_password.dart';


class SignIn extends StatefulWidget {
  static const String id = 'sign_in';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _emailController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _passwordController = TextEditingController();

  /// A boolean variable to hold whether the password should be shown or hidden
  bool _obscureTextLogin = true;

  bool _showSpinner = false;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/icons/register_logo.png",height:48.46,width:30,fit: BoxFit.contain,),
              SizedBox(height: 22.54,),
              Text(
                'Welcome Back!',
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
                'Login with your account details to\ncontinue.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 23,),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSignIn(),
                      SizedBox(height: 44,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){
                          if(_formKey.currentState.validate()){
                            _loginUser();
                          }
                        },
                        color: Color(0xFF00A69D),
                        child:  _showSpinner
                            ? CupertinoActivityIndicator(radius: 13)
                            :Text(
                          "Login",
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
                                    return SignUp();
                                  })
                              );

                            },
                            child:  RichText(
                              text:TextSpan(
                                  text: "Not yet a register user?\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "Create An Account",
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
                          child: FlatButton(
                              onPressed: null,
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

  Widget _buildSignIn() {
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
          SizedBox(height: 20,),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:(){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return Reset();
                      })
                  );
                },
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
          )
        ],
      ),
    );
  }

  /// A function to toggle if to show the password or not by
  /// changing [_obscureTextLogin] value
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _loginUser(){
    if(!mounted) return;
    setState(() {
      _showSpinner = true;
    });
    var api = AuthRestDataSource();
    api.signIn(_emailController.text, _passwordController.text).then((User user) async{
      _emailController.clear();
      _passwordController.clear();
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
      });
      print(user.toJson());
      var db = DatabaseHelper();
      await db.initDb();
      await db.saveUser(user);
      _addBoolToSF(true, user);
    }).catchError((e){
      print(e);
      _passwordController.clear();
      if(!mounted)return;
      setState(() {
        _showSpinner = false;

      });
      Constants.showError(context,e);
    });
  }

  /// This function adds a [state] boolean value to the device
  /// [SharedPreferences] logged in
  _addBoolToSF(bool state, User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', state);
    Navigator.push(context,
        CupertinoPageRoute(builder: (_){
          return HomeScreen();
        })
    );
  }
}
