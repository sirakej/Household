import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class PasswordAndSecurity extends StatefulWidget {

  static const String id = 'password_and_security';

  @override
  _PasswordAndSecurityState createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's old password
  TextEditingController _oldPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _newPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _confirmPasswordController = TextEditingController();

  /// A boolean variable to hold whether the password should be shown or hidden
  bool _obscureOldTextLogin = true;
  bool _obscureTextLogin = true;
  bool _obscureConfirmTextLogin = true;

  /// A boolean value holing true or false if the first validation rule is satisfied for password input
  bool _condition1 = false;

  /// A boolean value holing true or false if the second validation rule is satisfied for password input
  bool _condition2 = false;

  /// A boolean value holing true or false if the third validation rule is satisfied for password input
  bool _condition3 = false;

  /// A boolean variable to hold the password if it is validated or not
  bool _passwordValidated = false;

  /// A string variable holding the new password
  String _password = '';

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 22),
            _buildEditProfile(),
            SizedBox(height: 64),
            Button(
              onTap: (){
                if(_formKey.currentState.validate() && _passwordValidated){
                  _changePassword();
                }
              },
              buttonColor: Color(0xFF00A69D),
              child: Center(
                child:  _showSpinner
                    ? CupertinoActivityIndicator(radius: 13)
                    : Text(
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
            ),
          ],
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
                "Old Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFFFFFFF),
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  obscureText: _obscureOldTextLogin,
                  controller: _oldPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your old password';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      suffixIcon: TextButton(
                        onPressed:_toggleOldPassLogin,
                        child:_obscureTextLogin
                            ? Text(
                          "show",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        )
                            : Text(
                          "Hide",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
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
                "New Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFFFFFFF),
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  obscureText: _obscureTextLogin,
                  controller: _newPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  onChanged: (value){
                    setState(() {
                      _password = _newPasswordController.text;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your password';
                    }
                    if((!_condition1 && !_condition2) || (!_condition2 && !_condition3) || (!_condition1 && !_condition3)){
                      Functions.showError(context, "Password too weak");
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      suffixIcon: TextButton(
                        onPressed:_togglePassLogin,
                        child:_obscureTextLogin ?
                        Text(
                          "show",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ): Text(
                          "Hide",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
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
                  fontWeight: FontWeight.normal,
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
                  obscureText: _obscureConfirmTextLogin,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Confirm your password';
                    }
                    if (_confirmPasswordController.text != _newPasswordController.text) {
                      return 'Password Mismatch';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      suffixIcon: TextButton(
                        onPressed:_toggleConfirmPassLogin,
                        child:_obscureTextLogin ?
                        Text(
                          "show",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ): Text(
                          "Hide",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
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
          SizedBox(height: 28),
        ]
      )
    );
  }

  /// A function to toggle if to show the password or not by
  /// changing [_obscurePassTextLogin] value
  void _toggleOldPassLogin() {
    setState(() {
      _obscureOldTextLogin = !_obscureOldTextLogin;
    });
  }

  void _togglePassLogin() {
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

  /// A function to toggle if to show the password or not by
  /// changing [_obscureConfirmPassTextLogin] value
  void _toggleConfirmPassLogin() {
    setState(() {
      _obscureConfirmTextLogin = !_obscureConfirmTextLogin;
    });
  }

  /// Function that changes a user's password by calling
  /// [changePassword] in the [RestDataSource] class
  void _changePassword() async {
    if(!mounted)return;
    setState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    await api.updatePassword(_oldPasswordController.text, _newPasswordController.text).then((value) {
      if(!mounted)return;
      setState(() { _showSpinner = false; });
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      Functions.showSuccess(
          context,
          'Password changed successfully',
        whereTo: (){
            Functions.logOut(context);
        }
      );
    }).catchError((e){
      if(!mounted)return;
      setState(() { _showSpinner= false; });
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      print(e);
      Functions.showError(context, e);
    });
  }

}
