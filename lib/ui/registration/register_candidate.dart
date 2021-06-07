import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class RegisterCandidate extends StatefulWidget {
  static const String id = 'register_candidate';
  @override
  _RegisterCandidateState createState() => _RegisterCandidateState();
}

class _RegisterCandidateState extends State<RegisterCandidate> {
  /// A string variable holding the selected state value
  String _selectedTribe;

  /// A list of string variables holding a list of all countries
  List<String> _tribe =[
    "Annang",
    "Bekwarra",
    "Berom",
    "Boki",
    "Delta-Igbo",
    "Efik",
    "Eregbe",
    "Esan",
    "Foreign – Béninois",
    "Foreign - Gambien",
    "Foreign – Ghanaian",
    "Foreign - Malien",
    "Hausa",
    "Ibibio",
    "Idoma",
    "Igala",
    "Igidi",
    "Igebe",
    "Igbo",
    "Isobo",
    "Ijaw",
    "Ika (Auchi)",
    "Itsekiri",
    "Obanliku",
    "Ogoja",
    "Oron",
    "Ugep",
    "Ukwuani",
    "Urhobo",
    "Tiv",
    "Yoruba",
    "Other"
  ];

  /// A string variable holding the selected state value
  String _selectedReligion;

  /// A list of string variables holding a list of all countries
  List<String> _religion =[
    "Buddhism",
    "Christianity – Anglican",
    "Christianity – Catholic",
    "Christianity – Protestant",
    "Hinduism",
    "Islam",
    "Judaism",
    "None"
  ];


  /// A string variable holding the selected state value
  String _selectedExperience;

  /// A list of string variables holding a list of all countries
  List<String> _experience =[
    "0 years - 2 years",
    "2 years - 5 years",
    "5 years - 10 years",
    "10 years and above",
  ];

  /// A string variable holding the selected state value
  String _selectedGender;
  /// A list of string variables holding a list of all countries
  List<String> _gender =[
    "Male",
    "Female"
  ];

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


  /// A boolean variable to control showing of the progress indicator
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, right: 24, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/icons/register_logo.png",height:48.46,width:30,fit: BoxFit.contain,),
              SizedBox(height: 22.54,),
              Text(
                'Register As a Candidate',
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
                'Experienced, Professional & Vetted',
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
                        },
                        color: Color(0xFF00A69D),
                        child:  _showSpinner
                            ? CupertinoActivityIndicator(radius: 13)
                            :Text(
                          "Register",
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Age",
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
                          height: 60,
                          width: SizeConfig.screenWidth,
                          child: TextFormField(
                            controller: _mobileController,
                            keyboardType: TextInputType.number,
                            //textInputAction: TextInputAction.next,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Enter age';
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
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
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
                            height: 60,
                            width: SizeConfig.screenWidth / 2.4,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gelion',
                              ),
                              icon: Image.asset(
                                  'assets/icons/arrow-down.png',
                                  height: 18,
                                  width: 18,
                                  fit: BoxFit.contain
                              ),
                              value: _selectedReligion,
                              onChanged: (String value){
                                if(!mounted)return;
                                setState(() {
                                  _selectedReligion = value;
                                });
                              },
                              validator: (value){
                                if (_selectedReligion == null || _selectedReligion.isEmpty){
                                  return 'Pick your option';
                                }
                                return null;
                              },
                              decoration: kFieldDecoration.copyWith(
                                //contentPadding: EdgeInsets.only(right: 10),
                                hintText: 'Please Select',
                                hintStyle: TextStyle(
                                  color: Color(0xFF717F88),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                ),
                              ),
                              selectedItemBuilder: (BuildContext context){
                                return _religion.map((value){
                                  return Text(
                                    value,
                                    style: TextStyle(
                                      color: Color(0xFF1C2D55),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gelion',
                                    ),
                                  );
                                }).toList();
                              },
                              items: _religion.map((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gelion',
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tribe",
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
                        //height: 70,
                        width: SizeConfig.screenWidth / 2.4,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                          ),
                          icon: Image.asset(
                              'assets/icons/arrow-down.png',
                              height: 18,
                              width: 18,
                              fit: BoxFit.contain
                          ),
                          value: _selectedTribe,
                          onChanged: (String value){
                            if(!mounted)return;
                            setState(() {
                              _selectedTribe = value;
                            });
                          },
                          validator: (value){
                            if (_selectedTribe == null || _selectedTribe.isEmpty){
                              return 'Pick your option';
                            }
                            return null;
                          },
                          decoration: kFieldDecoration.copyWith(
                            //contentPadding: EdgeInsets.only(right: 10),
                            hintText: 'Please Select',
                            hintStyle: TextStyle(
                              color: Color(0xFF717F88),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                            ),
                          ),
                          selectedItemBuilder: (BuildContext context){
                            return _tribe.map((value){
                              return Text(
                                value,
                                style: TextStyle(
                                  color: Color(0xFF1C2D55),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                ),
                              );
                            }).toList();
                          },
                          items: _tribe.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Religion",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height:10),
                      Container(
                        //height: 45,
                        width: SizeConfig.screenWidth / 2.4,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                          ),
                          icon: Image.asset(
                              'assets/icons/arrow-down.png',
                              height: 18,
                              width: 18,
                              fit: BoxFit.contain
                          ),
                          value: _selectedReligion,
                          onChanged: (String value){
                            if(!mounted)return;
                            setState(() {
                              _selectedReligion = value;
                            });
                          },
                          validator: (value){
                            if (_selectedReligion == null || _selectedReligion.isEmpty){
                              return 'Pick your option';
                            }
                            return null;
                          },
                          decoration: kFieldDecoration.copyWith(
                            //contentPadding: EdgeInsets.only(right: 10),
                            hintText: 'Please Select',
                            hintStyle: TextStyle(
                              color: Color(0xFF717F88),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                            ),
                          ),
                          selectedItemBuilder: (BuildContext context){
                            return _religion.map((value){
                              return Text(
                                value,
                                style: TextStyle(
                                  color: Color(0xFF1C2D55),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                ),
                              );
                            }).toList();
                          },
                          items: _religion.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height:24),
              Text(
                "Experience",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              Container(
                //height: 45,
                width: SizeConfig.screenWidth,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gelion',
                  ),
                  icon: Image.asset(
                      'assets/icons/arrow-down.png',
                      height: 18,
                      width: 18,
                      fit: BoxFit.contain
                  ),
                  value: _selectedExperience,
                  onChanged: (String value){
                    if(!mounted)return;
                    setState(() {
                      _selectedExperience = value;
                    });
                  },
                  validator: (value){
                    if (_selectedExperience == null || _selectedExperience.isEmpty){
                      return 'Pick your option';
                    }
                    return null;
                  },
                  decoration: kFieldDecoration.copyWith(
                    //contentPadding: EdgeInsets.only(right: 10),
                    hintText: 'Please Select',
                    hintStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                    ),
                  ),
                  selectedItemBuilder: (BuildContext context){
                    return _experience.map((value){
                      return Text(
                        value,
                        style: TextStyle(
                          color: Color(0xFF1C2D55),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                        ),
                      );
                    }).toList();
                  },
                  items: _experience.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24,),
            ]
        )
    );
  }


  /// Function to build the widget of conditions passed

  /// Function that creates a new user by calling
  /// [signUp] in the [AuthRestDataSource] class

//  void _signUp(){
//    if(!mounted)return;
//    setState(() {
//      _showSpinner = true;
//    });
//    var api = AuthRestDataSource();
//    api.signUp(_firstController.text,_surnameController.text, _emailController.text,_mobileController.text, _passwordController.text).then((User user)async {
//      _firstController.clear();
//      _surnameController.clear();
//      _emailController.clear();
//      _mobileController.clear();
//      _passwordController.clear();
//      if(!mounted)return;
//      setState(() {
//        _showSpinner = false;
//      });
//      var db=DatabaseHelper();
//      await db.initDb();
//      await db.saveUser(user);
//      _addBoolToSF(true,user);
//    }).catchError((e){
//      print(e);
//      _passwordController.clear();
//      if (!mounted) return;
//      setState(() { _showSpinner = false; });
//      Constants.showError(context, e);
//    });
//  }

//  /// This function adds a [state] boolean value to the device
//  /// [SharedPreferences] logged in
//  _addBoolToSF(bool state, User user) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setBool('loggedIn', state);
//    Navigator.pushNamedAndRemoveUntil(context, UserCreatedSuccessfully.id, (route) => false);
//
//  }
//


}
