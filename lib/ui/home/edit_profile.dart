import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/ui/home/password_and_security.dart';
import 'package:householdexecutives_mobile/ui/home/saved_candidate.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  File _image;

  Future<void> _getImage() async {
    try{
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);

      if(!mounted)return;
      setState(() {
        _image = File(pickedFile.path);
      });
    } catch (e){
      print(e);
      if(e.toString().contains('PlatformException')){
        _buildImageRequest();
      }
      Constants.showInfo(context, 'You haven\'t selected an image');
    }
  }

  final _picker = ImagePicker();

  Future<void> _buildImageRequest(){
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 0.0,
        child: Container(
          width: 300,
          height: 165,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF).withOpacity(0.91),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Note',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: Color(0xFF1D1D1D)
                    ),
                  )
              ),
              Container(
                width: 260,
                padding: EdgeInsets.only(top: 12, bottom: 11),
                child: Text(
                  "You disabled permission to access your storage. Please enable access to your storage in settings to upload images",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
              Container(
                width: 252,
                height: 1,
                color: Color(0xFF9C9C9C).withOpacity(0.44),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 11),
                  child: Text(
                    'Ok',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: Color(0xFF1FD47D)
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

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _firstController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _surnameController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
//  TextEditingController _emailController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _mobileController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's password
  TextEditingController _passwordController = TextEditingController();

  /// A boolean variable to hold whether the password should be shown or hidden
  bool _obscureTextLogin = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// A boolean variable to control showing of the progress indicator
  bool _showSpinner = false;


  /// A String variable to hold the user's first name
  String _firstName = '';

  /// A String variable to hold the user's first name
  String _id = '';

  /// A String variable to hold the user's last name
  String _surName = '';

  /// A String variable to hold the user's email
  String _email = '';

  /// A String variable to hold the user's phone number
  String _phoneNumber = '';

  /// A String variable to hold the user's image url
  String _imageUrl = '';

  /// Setting the current user's details to [_userId], [_fullName],
  /// [_username] and [_phoneNumber]
  void _getCurrentUser() async {
    // await futureValue.updateUser();
    await futureValue.getCurrentUser().then((user) {
      if(!mounted)return;
      setState(() {
       // _imageUrl = user.profileImage;
        _id = user.id;
        _firstName = user.firstName;
        _surName = user.surName;
        _email = user.email;
        _phoneNumber = user.phoneNumber;
      });
    }).catchError((Object error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

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
                  IconButton(
                      onPressed: () {
                        _buildModalSheet(context);
                      },
                      icon:Icon(
                        Icons.menu,
                        size: 20,
                        color: Color(0xFF000000),
                      )
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
                                onPressed:(){
                                  if(_formKey.currentState.validate()){
                                    _updateUser();
                                  }
                                },
                                color: Color(0xFF00A69D),
                                child:   _showSpinner
                                    ? CupertinoActivityIndicator(radius: 13)
                                    :Text(
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
                          hintText: '$_firstName',
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
                          hintText: '$_surName',
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
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Text(
//                    "Email Address",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      fontWeight: FontWeight.w400,
//                      fontFamily: 'Gelion',
//                      fontSize: 14,
//                      color: Color(0xFF042538),
//                    ),
//                  ),
//                  SizedBox(height: 10,),
//                  Container(
//                    color: Color(0xFFFFFFFF),
//                    width: SizeConfig.screenWidth,
//                    child: TextFormField(
//                      controller: _emailController,
//                      keyboardType: TextInputType.emailAddress,
//                      textInputAction: TextInputAction.next,
//                      validator: (value){
//                        if(value.isEmpty){
//                          return 'Enter your email address';
//                        }
//                        return null;
//                      },
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontWeight: FontWeight.w400,
//                        fontFamily: 'Gelion',
//                        color: Color(0xFF042538),
//                      ),
//                      decoration:kFieldDecoration.copyWith(
//                          hintText: 'placeholder@mail.com',
//                          hintStyle:TextStyle(
//                            color:Color(0xFF717F88),
//                            fontSize: 14,
//                            fontFamily: 'Gelion',
//                            fontWeight: FontWeight.w400,
//                          )
//                      ),
//                    ),
//                  ),
//                ],
//              ),
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
                          hintText: '$_phoneNumber',
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
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Container(
                        //height: SizeConfig.screenHeight,
                        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        margin: EdgeInsets.only(top: 34),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisSize:  MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 64),
                            Center(
                              child: Text(
                                "Akande Seun",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF042538),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
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
                            SizedBox(height: 8,),
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
                            SizedBox(height:15,),
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
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/icons/profile.png",
                                // width: 90,
                                // height: 90,
                                fit:BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                padding: EdgeInsets.only(right: 24),
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  child: FloatingActionButton(
                                      elevation: 30,
                                      backgroundColor: Color(0xFF00A69D).withOpacity(0.25),
                                      shape: CircleBorder(),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        }
    );
  }

  void _updateUser() async {
    if(!mounted)return;
    setState(() {
      _showSpinner = true;
    });
    var api = AuthRestDataSource();
    await api.updateProfile(_firstController.text,_surnameController.text, _email,_mobileController.text).then((value) async {
      await futureValue.updateUser();
      var db = DatabaseHelper();
      await db.updateUser(value);
      if (!mounted) return;
      setState(() { _showSpinner = false; });
    }).catchError((e) {
      print(e);
      if (!mounted) return;
      setState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

}
