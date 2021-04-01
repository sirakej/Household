import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class PasswordAndSecurity extends StatefulWidget {
  static const String id = 'password_and_security';
  @override
  _PasswordAndSecurityState createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {
  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _passwordController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _confirmPasswordController = TextEditingController();

  /// A boolean variable to hold whether the password should be shown or hidden
  bool _obscureTextLogin = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24,right: 24),
          child: Column(
            children: [
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    size: 20,
                    color: Color(0xFF000000),
                  ),
                  InkWell(
                      onTap: (){},
                      child: Image.asset("assets/icons/notification_baseline.png",height: 24,width:24,fit: BoxFit.contain,)
                  )
                ],
              ),
              SizedBox(height:37),
              Center(
                child: Text(
                  "Update your Password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    fontSize: 19,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 22,),
                        _buildEditProfile(),
                        SizedBox(height: 64,),
                        FlatButton(
                          minWidth: SizeConfig.screenWidth,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.only(top:18 ,bottom: 18),
                          onPressed:(){},
                          color: Color(0xFF00A69D),
                          child: Text(
                            "Save",
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
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEditProfile() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
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
                    color: Color(0xFFFFFFFF),
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
              SizedBox(height:16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Re-enter Password",
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
                    color: Color(0xFFFFFFFF),
                    width: SizeConfig.screenWidth,
                    child: TextFormField(
                      obscureText: _obscureTextLogin,
                      controller: _confirmPasswordController,
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

}
