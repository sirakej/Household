import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/registration/register-candidate-two.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/model/create-candidate.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class RegisterCandidateOne extends StatefulWidget {

  static const String id = 'register_candidate_one';

  @override
  _RegisterCandidateOneState createState() => _RegisterCandidateOneState();
}

class _RegisterCandidateOneState extends State<RegisterCandidateOne> {

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

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

  /// A list of string variables holding a list of all tribes
  List<String> _tribe =[
    "Annang", "Bekwarra", "Berom", "Boki", "Delta-Igbo", "Efik", "Eregbe",
    "Esan", "Foreign – Béninois", "Foreign - Gambien", "Foreign – Ghanaian",
    "Foreign - Malien", "Hausa", "Ibibio", "Idoma", "Igala", "Igidi", "Igebe",
    "Igbo", "Isobo", "Ijaw", "Ika (Auchi)", "Itsekiri", "Obanliku", "Ogoja",
    "Oron", "Ugep", "Ukwuani", "Urhobo", "Tiv", "Yoruba", "Other"
  ];

  /// A string variable holding the selected tribe value
  String _selectedTribe;

  /// A list of string variables holding a list of all religion
  List<String> _religion =[
    "Buddhism", "Christianity – Anglican", "Christianity – Catholic",
    "Christianity – Protestant", "Hinduism", "Islam", "Judaism", "None"
  ];

  /// A string variable holding the selected religion value
  String _selectedReligion;

  /// A list of string variables holding a list of all gender
  List<String> _gender =[
    "Male", "Female", "Other"
  ];

  /// A string variable holding the selected gender value
  String _selectedGender;

  /// A Map of string and int variables holding the experience and the value to
  /// pass to the api
  Map<String, int> _experienceValues = {
    "0 years - 2 years": 1,
    "2 years - 5 years": 2,
    "5 years - 10 years": 3,
    "10 years and above": 4
  };

  /// A list of string variables holding a list of all experiences
  List<String> _experience =[
    "0 years - 2 years",
    "2 years - 5 years",
    "5 years - 10 years",
    "10 years and above",
  ];

  /// A string variable holding the selected experience value
  String _selectedExperience;

  /// A [TextEditingController] to control the input text for the categories
  TextEditingController _categoryController = TextEditingController();

  /// A list of string variables holding a list of all area of service
  List<String> _areaOfService =[
    "Lagos Island",
    "Lagos Mainland",
    "Any of the Above"
  ];

  /// A string variable holding the selected area of service
  String _selectedAreaOfService;

  /// A List to hold the all the categories
  List<Category> _categories = [];

  /// A List to hold the all the selected categories
  List<Category> _allSelectedCategories = [];

  Category _selectedCategory;

  /// An Integer variable to hold the length of [_categories]
  int _categoriesLength;

  /// A List to hold the widgets of all the category widgets
  List<Widget> _categoriesList = [];

  /// [This function gets all the categories in the db to put in [_categories]
  void _allCategories() async {
    Future<List<Category>> names = futureValue.getAllCategories();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _categoriesLength = 0;
          _categories = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _categories.addAll(value.reversed);
          _categoriesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  @override
  void initState(){
    super.initState();
    _allCategories();
  }

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
                  'Register as a Candidate',
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
                  'Join our team of professionals',
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
                            if(_allSelectedCategories.length > 0){
                              if(_formKey.currentState.validate()){
                                _registerCandidate();
                              }
                            }
                            else {
                              Functions.showInfo(context, 'Select at least one category of what you do');
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
          // Email Address
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
          // Category
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
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
                child: DropdownButtonFormField<Category>(
                  isExpanded: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  icon: Image.asset(
                      'assets/icons/arrow-down.png',
                      height: 18,
                      width: 18,
                      fit: BoxFit.contain
                  ),
                  value: _selectedCategory,
                  onChanged: (Category value){
                    if(!mounted)return;
                    setState(() {
                      if(!_allSelectedCategories.contains(value)){
                        _allSelectedCategories.add(value);
                      }
                      _selectedCategory = null;
                    });
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
                    return _categories.map((value){
                      return Text(
                        value.category.singularName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                      );
                    }).toList();
                  },
                  items: _categories.map((Category value){
                    return DropdownMenuItem<Category>(
                      value: value,
                      child: Text(
                        value.category.singularName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              _buildCategoryList(),
            ],
          ),
          SizedBox(height: 20),
          // First Name
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
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
                      hintText: 'First Name',
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
          // Last Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Surname",
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your Surname';
                    }
                    if (value.length < 3){
                      return 'Surname should be at least 3 characters';
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
                    hintText: 'Surname',
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
          // Gender and Tribe
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            color: Color(0xFF042538),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  color: Color(0xFF042538),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  color: Color(0xFF042538),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tribe (Optional)",
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
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
                          setState(() => _selectedTribe = value);
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Phone Number
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
                  onInputChanged: (PhoneNumber number) => _number = number,
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      showFlags: true,
                      useEmoji: true
                  ),
                  ignoreBlank: true,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 13,
                  countries: ['NG'],
                  validator: (value) {
                    if (value.isEmpty) return 'Enter your phone number';
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
                  keyboardType: TextInputType.phone,
                  inputBorder: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Age and Experience
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age (Optional)",
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
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
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
                          setState(() { _selectedExperience = value; });
                        },
                        validator: (value){
                          if (_selectedExperience == null || _selectedExperience.isEmpty){
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
                          return _experience.map((value){
                            return Text(
                              value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Religion and Area of Service
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Religion (Optional)",
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Area of Service",
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                        icon: Image.asset(
                            'assets/icons/arrow-down.png',
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain
                        ),
                        value: _selectedAreaOfService,
                        onChanged: (String value){
                          if(!mounted)return;
                          setState(() {
                            _selectedAreaOfService = value;
                          });
                        },
                        validator: (value){
                          if (_selectedAreaOfService == null || _selectedAreaOfService.isEmpty){
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
                          return _areaOfService.map((value){
                            return Text(
                              value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
                              ),
                            );
                          }).toList();
                        },
                        items: _areaOfService.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
                              ),
                            ),
                          );
                        }).toList(),
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

  /// Function to build the selected category list in a row
  Widget _buildCategoryList(){
    List<Widget> categoryContainer = [];
    if(_allSelectedCategories.length <= 0){
      categoryContainer.add(Container());
    }
    else {
      for(int i = 0; i < _allSelectedCategories.length; i++){
        if(_allSelectedCategories[i] != null){
          categoryContainer.add(
            InkWell(
              onTap: (){
                if(!mounted)return;
                setState(() {
                  _allSelectedCategories.removeAt(i);
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 9.73, right: 3.89242),
                margin: EdgeInsets.only(right: 7.78484, bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(color: Color(0xFF757575), width: 0.486553, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.78484))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _allSelectedCategories[i].category.singularName,
                      style: TextStyle(
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF0C0C0C)
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.close_sharp,
                      size: 12,
                      color: Color(0xFF000000),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: categoryContainer,
    );
  }

  /// Function to save the user's details in [CreateCandidate] model then move
  /// to the next phase of registration [RegisterCandidateTwo]
  void _registerCandidate(){
    try {
      var candidate = CreateCandidate();
      candidate.firstName = Functions.capitalize(_firstNameController.text.trim());
      candidate.lastName = Functions.capitalize(_lastNameController.text.trim());
      candidate.email = _emailController.text.toLowerCase().trim();
      candidate.phoneNumber = _number.phoneNumber.trim();
      if(_ageController.text.isNotEmpty) {
        candidate.age = int.parse(_ageController.text);
      } else {
        candidate.age = null;
      }
      candidate.origin = _selectedAreaOfService;
      candidate.tribe = _selectedTribe;
      candidate.gender = _selectedGender;
      candidate.religion = _selectedReligion;
      candidate.experience = _experienceValues[_selectedExperience];
      List<String> category = [];
      _allSelectedCategories.forEach((value) {
        category.add(value.category.id);
      });
      candidate.category = jsonEncode(category);
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
