import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/registration/register-candidate-two.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/model/create-candidate.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterCandidateOne extends StatefulWidget {

  static const String id = 'register_candidate_one';

  @override
  _RegisterCandidateOneState createState() => _RegisterCandidateOneState();
}

class _RegisterCandidateOneState extends State<RegisterCandidateOne> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's first name
  TextEditingController _firstNameController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's last name
  TextEditingController _lastNameController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _emailController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's phone number
  TextEditingController _phoneNumberController = TextEditingController();

  /// A PhoneNumber variable from InternationalPhoneNumberInput package to hold
  /// the phone number details
  PhoneNumber _number = PhoneNumber(isoCode: 'NG');

  /// A [TextEditingController] to control the input text for the user's age
  TextEditingController _ageController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's state of origin
  TextEditingController _originController = TextEditingController();

  /// A [TextEditingController] to control the input text for the user's experience
  TextEditingController _experienceController = TextEditingController();

  /// A list of string variables holding a list of all tribes
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
  String _selectedTribe;

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
  String _selectedReligion;

  /// A list of string variables holding a list of all countries
  List<String> _gender =[
    "Male",
    "Female"
  ];

  /// A string variable holding the selected state value
  String _selectedGender;

  /// A list of string variables holding a list of all countries
  List<String> _experience =[
    "0 years - 2 years",
    "2 years - 5 years",
    "5 years - 10 years",
    "10 years and above",
  ];

  /// A string variable holding the selected state value
  String _selectedExperience;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF3F6F8),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icons/register_logo.png",
                      height: 48.46,
                      width: 30,
                      fit: BoxFit.contain
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Go Back',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.54),
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
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                    color: Color(0xFF57565C),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 33),
                        _buildForm(),
                        SizedBox(height: 60),
                        Button(
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              _registerCandidate();
                            }
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Next",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: Color(0xFFFFFFFF)
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This function builds the form widget for user to fill and validate their
  /// details
  Widget _buildForm() {
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
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _firstNameController,
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
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      hintText: 'Precious',
                      hintStyle:TextStyle(
                        color:Color(0xFF717F88),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last Name",
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
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your Last Name';
                    }
                    if (value.length < 3){
                      return 'Last name should be at least 3 characters';
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
                    hintText: 'Akande',
                    hintStyle:TextStyle(
                        color:Color(0xFF717F88),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email Address",
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
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                      hintText: 'placeholder@mail.com',
                      hintStyle:TextStyle(
                        color:Color(0xFF717F88),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phone Number",
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
                width: SizeConfig.screenWidth,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    _number = number;
                  },
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      showFlags: true,
                      useEmoji: true
                  ),
                  ignoreBlank: true,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                  spaceBetweenSelectorAndTextField: 8,
                  selectorTextStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  inputDecoration: kFieldDecoration.copyWith(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        color:Color(0xFF717F88),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.normal,
                      )
                  ),
                  initialValue: _number,
                  textFieldController: _phoneNumberController,
                  formatInput: true,
                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
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
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: SizeConfig.screenWidth,
                      child: TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter age';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                        decoration:kFieldDecoration.copyWith(
                            hintText: 'Please enter age',
                            hintStyle:TextStyle(
                              color:Color(0xFF717F88),
                              fontSize: 14,
                              fontFamily: 'Gelion',
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Origin",
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
                      width: SizeConfig.screenWidth,
                      child: TextFormField(
                        controller: _originController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter state of origin';
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
                            hintText: 'Enter state of origin',
                            hintStyle:TextStyle(
                              color:Color(0xFF717F88),
                              fontSize: 14,
                              fontFamily: 'Gelion',
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tribe",
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
                          hintText: 'Please Select',
                          hintStyle: TextStyle(
                            color: Color(0xFF717F88),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
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
              ),
              SizedBox(width: 10),
              Expanded(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
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
                          value: _selectedGender,
                          onChanged: (String value){
                            if(!mounted)return;
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value){
                            if (_selectedGender == null || _selectedGender.isEmpty){
                              return 'Pick your option';
                            }
                            return null;
                          },
                          decoration: kFieldDecoration.copyWith(
                            hintText: 'Please Select',
                            hintStyle: TextStyle(
                              color: Color(0xFF717F88),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                            ),
                          ),
                          selectedItemBuilder: (BuildContext context){
                            return _gender.map((value){
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
                          items: _gender.map((String value){
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
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Religion",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
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
                          hintText: 'Please Select',
                          hintStyle: TextStyle(
                            color: Color(0xFF717F88),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
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
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: SizeConfig.screenWidth,
                      child: TextFormField(
                        controller: _experienceController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter experience';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                        decoration:kFieldDecoration.copyWith(
                            hintText: 'Enter experience',
                            hintStyle:TextStyle(
                              color:Color(0xFF717F88),
                              fontSize: 14,
                              fontFamily: 'Gelion',
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]
      )
    );
  }

  /// Function to save the user's details in [CreateCandidate] model then move
  /// to the next phase of registration [RegisterCandidateTwo]
  void _registerCandidate(){
    try {
      var candidate = CreateCandidate();
      candidate.firstName = Constants.capitalize(_firstNameController.text.trim());
      candidate.lastName = Constants.capitalize(_lastNameController.text.trim());
      candidate.email = _emailController.text.toLowerCase().trim();
      candidate.phoneNumber = _number.phoneNumber.trim();
      candidate.age = int.parse(_ageController.text);
      candidate.origin = _originController.text;
      candidate.tribe = _selectedTribe;
      candidate.gender = _selectedGender;
      candidate.religion = _selectedReligion;
      candidate.experience = int.parse(_experienceController.text);
      Navigator.push(context,
          CupertinoPageRoute(builder: (_){
            return RegisterCandidateTwo(candidate: candidate);
          })
      );
    } catch(e){
      print(e);
    }
  }

}
