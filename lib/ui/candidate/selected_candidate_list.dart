import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/location.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';

class SelectedCandidateList extends StatefulWidget {

  static const String id = 'selected_candidate';

  @override
  _SelectedCandidateListState createState() => _SelectedCandidateListState();
}

class _SelectedCandidateListState extends State<SelectedCandidateList> {

  Location _location = Location();

  /// A list of string variables holding a list of all countries
  List<String> _state = List<String>();

  /// A string variable holding the selected country value
  String _selectedState;

  /// A list of string variables holding a list of all states of a specified country
  List<String> _region = List<String>();

  /// A string variable holding the selected state value
  String _selectedRegion;

  double _lowerValue = 50;

  double _upperValue = 180;

  @override
  void initState() {
    _state = List.from(_state)..addAll(_location.getCountries());
    super.initState();
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
                    Text(
                      'Find a candidate!',
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
                      'Aliqua id fugiat nostrud irure ex duis ea quis\nid quis ad et. ',
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
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
                        CandidateContainer(
                          candidateName: 'Aderonke',
                          candidateGender: 'female',
                          candidateExperienceYears: '2 Years Experience',
                          candidateAvailability: 'Available Weekdays',
                          candidateCity: 'Lagos',
                          imagePath: 'butler',
                          ratings: 3.5,
                        ),
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
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Column(
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
                              setModalState(() {
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
                              setModalState(() {
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
                                "State of Origin",
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
                                    color: Color(0xFF000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gelion',
                                  ),
                                  value: _selectedState,
                                  icon: Image.asset(
                                    'assets/icons/arrow-down.png',
                                    height: 18,
                                    width: 18,
                                    fit: BoxFit.contain
                                  ),
                                  onChanged: (String value){
                                    if(!mounted)return;
                                    setState(() {
                                      _region = [];
                                      _selectedRegion = null;
                                      _region = List.from(_region)..addAll(_location.getLocalByCountry(value));
                                      _selectedState = value;
                                    });
                                  },
                                  validator: (value){
                                    if (_selectedState == null || _selectedState.isEmpty){
                                      return 'Pick your option';
                                    }
                                    return null;
                                  },
                                  decoration: kFieldDecoration.copyWith(
                                    hintText: 'Please Select',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF717F88),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                    ),
                                  ),
                                  selectedItemBuilder: (BuildContext context){
                                    return _state.map((value){
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
                                  items: _state.map((String value){
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
                                "Region",
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
                                  value: _selectedRegion,
                                  onChanged: (String value){
                                    if(!mounted)return;
                                    setState(() {
                                      _selectedRegion = value;
                                    });
                                  },
                                  validator: (value){
                                    if (_selectedRegion == null || _selectedRegion.isEmpty){
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
                                    return _region.map((value){
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
                                  items: _region.map((String value){
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
                      RangeSlider(
                        //inactiveColor: Color(0xFFFFFFFF),
                        values:RangeValues(0 , 0),
                        onChanged: (RangeValues value) {  },
                      ),
                      SizedBox(height:27),
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
//                        FlutterSlider(
//                          values: [1000, 15000],
//                          rangeSlider: true,
//
////rtl: true,
//                          ignoreSteps: [
//                            FlutterSliderIgnoreSteps(from: 8000, to: 12000),
//                            FlutterSliderIgnoreSteps(from: 18000, to: 22000),
//                          ],
//                          max: 25000,
//                          min: 0,
//                          step: FlutterSliderStep(step: 100),
//
//                          jump: true,
//
//                          trackBar: FlutterSliderTrackBar(
//                            activeTrackBarHeight: 2,
//                            activeTrackBar: BoxDecoration(color: Colors.brown),
//                          ),
//                          tooltip: FlutterSliderTooltip(
//                            textStyle: TextStyle(fontSize: 17, color: Colors.lightBlue),
//                          ),
//                          handler: FlutterSliderHandler(
//                            decoration: BoxDecoration(),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                  color: Colors.brown,
//                                  borderRadius: BorderRadius.circular(25)),
//                              padding: EdgeInsets.all(10),
//                              child: Container(
//                                padding: EdgeInsets.all(5),
//                                decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(25)),
//                              ),
//                            ),
//                          ),
//                          rightHandler: FlutterSliderHandler(
//                            decoration: BoxDecoration(),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                  color: Colors.brown,
//                                  borderRadius: BorderRadius.circular(25)),
//                              padding: EdgeInsets.all(10),
//                              child: Container(
//                                padding: EdgeInsets.all(5),
//                                decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(25)),
//                              ),
//                            ),
//                          ),
//                          disabled: false,
//
//                          onDragging: (handlerIndex, lowerValue, upperValue) {
//                            _lowerValue = lowerValue;
//                            _upperValue = upperValue;
//                            setState(() {});
//                          },
//                        ),
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
                                  setModalState((){
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
                                  setModalState((){
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
                                  setModalState((){
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
                                  setModalState((){
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
            );
          });
        }
    );
  }



}
