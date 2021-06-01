import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/custom_slider.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';

import '../packages.dart';

class SelectedCandidateList extends StatefulWidget {

  static const String id = 'selected_candidate';
  final Category category;

  const SelectedCandidateList({
    Key key,
    @required this.category,
  }) : super(key: key);
  @override
  _SelectedCandidateListState createState() => _SelectedCandidateListState();
}

class _SelectedCandidateListState extends State<SelectedCandidateList> {

  bool isPressed = false;
  bool isShow = false;
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


  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A List to hold the all the available plans
  List<Candidate> _candidates = List();

  Map<Candidate,bool> _selectedCandidate= {};

  /// An Integer variable to hold the length of [_plans]
  int _candidatesLength;

  /// A List to hold the widgets of all the plans
  List<Widget> _candidatesList = [];

  /// Function to fetch all the available plans from the database to
  /// [allCategories]
  void _allCandidates() async {
    Future<List<Candidate>> names = futureValue.getAllCandidateFromDB(widget.category.category.id);
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _candidatesLength = 0;
          _candidates = [];
          _selectedCandidate = {};
        });
      } else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _candidates.addAll(value);
          for(int i = 0 ; i < value.length ; i++){
            _selectedCandidate[value[i]] = false;
          }
          _candidatesLength = value.length;
        });
      }
    }).catchError((error){
      print(error);
      Constants.showError(context, error.toString());
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      _candidatesList.clear();
      for (int i = 0; i < _candidates.length; i++){
        if(!_selectedCandidate[_candidates[i]]) {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _candidates[i],
                category: widget.category,
              ),
            ),
          );
        }
      }

      return Column(
        children: _candidatesList,
      );
    }
    else if(_candidatesLength == 0){
      return Container();
    }
    return Center(child: CupertinoActivityIndicator(radius: 15));
  }

  //bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _allCandidates();
    print(_allCandidates);
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 24),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: IconButton(
                  iconSize: 1,
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 19,
                      color: Color(0xFF000000),
                    ),
                    onPressed:(){Navigator.pop(context);}
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 24, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.category.category.name}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                            fontSize: 19,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Image.asset("assets/icons/chef-hat 1.png",height:22,width: 22,fit: BoxFit.contain,)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Text(
                      "${widget.category.category.description}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    SizedBox(height: 24,),
                    InkWell(
                      onTap: (){
                       _buildFilterModalSheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(11, 18, 14, 18),
                        decoration: BoxDecoration(
                            color: Color(0xFF00A69D).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 2,
                              color: Color(0xFF00A69D)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/icons/Filter.png",height:20,width:20,fit:BoxFit.contain),
                            SizedBox(width:10),
                            Text(
                              "Filter Results",
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
                    SizedBox(height: 8,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 24),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
//                        CandidateContainer(
//                          candidateName: 'Aderonke',
//                          candidateGender: 'female',
//                          candidateExperienceYears: '2 Years Experience',
//                          candidateAvailability: 'Available Weekdays',
//                          candidateCity: 'Lagos',
//                          imagePath: 'butler',
//                          ratings: 3.5,
//                        ),
                      _buildList(),
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


  _buildFilterModalSheet(BuildContext context){
    bool male = true;
    bool female = false;
    bool fullTime = false;
    bool partTime = false;
    bool weekDays = false;
    bool weekEnds = false;
    double _lowerValue = 20;
    double _upperValue = 50;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState){
            return  SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 8,),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 24, 24, 38),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisSize:  MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  male = true;
                                  female = false;
                                });
                              },
                              child: Container(
                                width: 91,
                                padding: EdgeInsets.only(top:18 ,bottom: 18),
                                decoration: BoxDecoration(
                                    color: male == true ? Color(0xFF00A69D).withOpacity(0.4):Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: male == true?Color(0xFF00A69D):Color(0xFFEBF1F4),
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    "Male",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: male == true ?Color(0xFF00A69D):Color(0xFF717F88),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 11,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  male = false;
                                  female = true;
                                });
                              },
                              child: Container(
                                width: 91,
                                padding: EdgeInsets.only(top:18 ,bottom: 18),
                                decoration: BoxDecoration(
                                    color: female == true ? Color(0xFF00A69D).withOpacity(0.4):Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: female == true?Color(0xFF00A69D):Color(0xFFEBF1F4),
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    "Female",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: female == true ?Color(0xFF00A69D):Color(0xFF717F88),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
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
                        SizedBox(height:27),
                        Text(
                          "Age Range",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ),
//                        RangeSlider(
//                            divisions: 100,
//                            activeColor: Color(0xFF00A69D),
//                            inactiveColor: Color(0xFFC4C4C4),
//                            min: 20,
//                            max: 50,
//                            values: values_1,
//                            labels: labels_1,
//                            onChangeStart:(value) {
//                              print("${value.start}");
//                            },
//                            onChangeEnd:(value) {
//                              print("${value.end}");
//                            },
//                            onChanged: (value){
//                              print("START: ${value.start}, End: ${value.end}");
//                              setState(() {
//                                values_1 =value;
//                                labels_1 =RangeLabels("${value.start.toInt().toString()}s", "${value.end.toInt().toString()}s");
//                              });
//                            }
//                        ),
                        FlutterSlider(
                          values: [_lowerValue,_upperValue],
                          rangeSlider: true,
//                        ignoreSteps: [
//                          FlutterSliderIgnoreSteps(from: 50, to: 20),
//                          FlutterSliderIgnoreSteps(from: 50, to: 20),
//                        ],
                          max: 50,
                          min: 20,
                          step: FlutterSliderStep(step: 1),
                          trackBar: FlutterSliderTrackBar(
                            activeTrackBarHeight: 1,
                            activeTrackBar: BoxDecoration(color: Color(0xFF00A69D)),
                          ),
//                        tooltip: FlutterSliderTooltip(
//                          textStyle: TextStyle(fontSize: 17, color: Colors.lightBlue),
//                        ),
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(),
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Color(0xFF00A69D),
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.all(1),
                              child: Container(

                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ),
                          ),
                          rightHandler: FlutterSliderHandler(
                            decoration: BoxDecoration(),
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Color(0xFF00A69D),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                          disabled: false,

                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            _lowerValue = lowerValue;
                            _upperValue = upperValue;
                            setState(() {});
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10,right:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${_lowerValue.toInt().toString()}s"),
                              Text("${_upperValue.toInt().toString()}s"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Availability",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState((){
                                      fullTime = !fullTime;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      fullTime == false
                                          ? Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          size: 18,
                                          color: Color(0xFFC4C4C4)
                                      )
                                          : Icon(
                                          Icons.radio_button_checked_outlined,
                                          size: 18,
                                          color: Color(0xFF00A69D)
                                      ),
                                      SizedBox(width: 7.75),
                                      Text(
                                        "Fulltime engagement",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 22,),
                                InkWell(
                                  onTap: (){
                                    setState((){
                                      weekDays = !weekDays;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      weekDays == false
                                          ? Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          size: 18,
                                          color: Color(0xFFC4C4C4)
                                      )
                                          : Icon(
                                          Icons.radio_button_checked_outlined,
                                          size: 18,
                                          color: Color(0xFF00A69D)
                                      ),
                                      SizedBox(width: 7.75),
                                      Text(
                                        "Weekdays",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState((){
                                      partTime = !partTime;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      partTime == false
                                          ? Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          size: 18,
                                          color: Color(0xFFC4C4C4)
                                      )
                                          : Icon(
                                          Icons.radio_button_checked_outlined,
                                          size: 18,
                                          color: Color(0xFF00A69D)
                                      ),
                                      SizedBox(width: 7.75),
                                      Text(
                                        "Partime engagement",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 22,),
                                InkWell(
                                  onTap: (){
                                    setState((){
                                      weekEnds = !weekEnds;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      weekEnds == false
                                          ? Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          size: 18,
                                          color: Color(0xFFC4C4C4)
                                      )
                                          : Icon(
                                          Icons.radio_button_checked_outlined,
                                          size: 18,
                                          color: Color(0xFF00A69D)
                                      ),
                                      SizedBox(width: 7.75,),
                                      Text(
                                        "Weekends",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height:37),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                              minWidth: SizeConfig.screenWidth/1.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.only(top:18 ,bottom: 18),
                              onPressed:(){},
                              color: Color(0xFF00A69D),
                              child: Text(
                                "Show Results",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed:(){},
                                child:Text(
                                  "Clear",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF717F88),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }
    );
  }
}
