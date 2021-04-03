import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/home/password_and_security.dart';
import 'package:householdexecutives_mobile/home/saved_candidate.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))
        ),
        child: SafeArea(
          child: Drawer(
            elevation: 20,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:55 ,),
                    Image.asset("assets/icons/profile.png",width: 64, height: 64, fit:BoxFit.contain,),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left:75,),
                  child: Column(
                      children:[
                        SizedBox(height:52),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return EditProfile();
                                })
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/pen_icon.png",width: 16.67, height:16.67, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Edit Profile",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF00A69D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return PasswordAndSecurity();
                                })
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/security_icon.png",width: 15, height:18.33, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Password & Security",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF5D6970),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return SavedCandidate();
                                })
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/saved_candidate_icon.png",width: 19.09, height:16.86, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Saved Candidates",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF5D6970),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  _buildModalSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setState /*You can rename this!*/){
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 24),
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 26,
                      height: 26,
                      child: FloatingActionButton(
                          elevation: 30,
                          backgroundColor: Color(0xFF00A69D).withOpacity(0.25),
                          shape:CircleBorder(),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Color(0xFFFFFFFF),
                            size:13,
                          )
                      ),
                    )
                ),
                SizedBox(height:8),
                Container(
                  //height: SizeConfig.screenHeight,
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: TextButton(
                          onPressed:(){
                            Navigator.pop(context);
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Text(
                            "Update profile information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF00A69D),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Color(0xFF00A69D)
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){},
                        color: Color(0xFF00A69D).withOpacity(0.4),
                        child: Text(
                          "Hire from a different category",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF00A69D),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Color(0xFFC4C4C4).withOpacity(0.48),
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){},
                        child: Text(
                          "View List",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF00A69D),
                          ),
                        ),
                      ),
                      SizedBox(height:20  ,),
                      Center(
                        child: TextButton(
                          onPressed:(){},
                          child: Text(
                            "Sign Out",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFFE36D45),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            );
          });
        }
    );
  }
}