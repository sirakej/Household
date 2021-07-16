import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/database/user-db-helper.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class EditProfile extends StatefulWidget {

  static const String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's first name
  TextEditingController _firstController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's surname
  TextEditingController _surnameController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _emailController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's number
  TextEditingController _mobileController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's address
  TextEditingController _physicalAddressController = TextEditingController();

  /// A boolean variable to control showing of the progress indicator
  bool _showSpinner = false;

  /// Setting the current user's details to [_userId], [_fullName],
  /// [_username] and [_phoneNumber]
  void _getCurrentUser() async {
    await futureValue.updateUser();
    await futureValue.getCurrentUser().then((user) {
      if(!mounted)return;
      setState(() {
        _firstController.text = user.firstName;
        _surnameController.text = user.surName;
        _emailController.text = user.email;
        _mobileController.text = user.phoneNumber;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: SafeArea(
        child: Column(
          children: [
            /*Center(
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
            ),*/
            (_firstController.text.isNotEmpty && _surnameController.text.isNotEmpty)
                ?  Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF00A69D),
            border: Border.all(color: Color(0xFF00A69D), width: 2)
          ),
          child: Center(
            child: Text(
              Functions.profileName('${_firstController.text} ${_surnameController.text}'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Gelion',
                fontSize: 24,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        )
                : Container(),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 22),
                          _buildEditProfile(),
                          SizedBox(height: 61),
                          Button(
                            onTap: (){
                              if(_formKey.currentState.validate()){
                                _updateUser();
                              }
                            },
                            buttonColor: Color(0xFF00A69D),
                            child: Center(
                              child: _showSpinner
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
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                  )
              )
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
                "First Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
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
                  controller: _firstController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
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
                      hintText: 'First Name',
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
          SizedBox(height: 24),
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
              SizedBox(height: 10),
              Container(
                color: Color(0xFFFFFFFF),
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _surnameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
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
          SizedBox(height: 24),
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
              SizedBox(height: 10),
              Container(
                color: Color(0xFFFFFFFF),
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9 -+]')),
                  ],
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
                      hintText: '0000000000',
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
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Physical Address",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
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
                  controller:_physicalAddressController,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  /*validator: (value){
                      if(value.isEmpty){
                        return 'Enter your Physical Address';
                      }
                      return null;
                    },*/
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      hintText: 'Address',
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
          )
        ]
      )
    );
  }

  void _updateUser() async {
    if(!mounted)return;
    setState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    await api.updateProfile(_firstController.text, _surnameController.text,
        _emailController.text, _mobileController.text).then((value) async {
      await futureValue.updateUser();
      var db = DatabaseHelper();
      await db.updateUser(value);
      if (!mounted) return;
      setState(() { _showSpinner = false; });
      Functions.showSuccess(context, 'Account updated successfully');
    }).catchError((e) {
      print(e);
      if (!mounted) return;
      setState(() { _showSpinner = false; });
      Functions.showError(context, e);
    });
  }

}
