import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
              SizedBox(height: 20,),
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
              Center(
                child: Container(
                  height: 85,
                  width: 80,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xFF00A69D).withOpacity(0.91),
                          ),
                          shape: BoxShape.circle
                        ),
                        child: Image.asset("assets/icons/profile.png",width:74,height:74,fit: BoxFit.contain,),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell
                          (
                          onTap: (){},
                            child: Image.asset("assets/icons/pencil.png",fit:BoxFit.contain,height: 40,width:40,)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                      child: Container(
                          child: Column(
                            children: [
                              SizedBox(height: 22,),
                              _buildEditProfile(),
                              SizedBox(height: 61,),
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
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              SizedBox(height:20),
                            ],
                          )
                      )
                  )
              ),

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
                    color: Color(0xFFFFFFFF),
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
              SizedBox(height: 16,),
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
                    color: Color(0xFFFFFFFF),
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
              SizedBox(height: 16,),
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
                    color: Color(0xFFFFFFFF),
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
                    color: Color(0xFFFFFFFF),
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
