import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';

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
                if(_formKey.currentState.validate()){
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
                  textInputAction: TextInputAction.done,
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
              SizedBox(height: 10,),
              Container(
                color: Color(0xFFFFFFFF),
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  obscureText: _obscureTextLogin,
                  controller: _newPasswordController,
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
      Constants.showSuccess(context, 'Password changed successfully');
    }).catchError((e){
      if(!mounted)return;
      setState(() { _showSpinner= false; });
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      print(e);
      Constants.showError(context, e);
    });
  }

}
