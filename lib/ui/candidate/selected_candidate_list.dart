import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/location.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class SelectedCandidateList extends StatefulWidget {
  static const String id = 'selected_candidate';
  @override
  _SelectedCandidateListState createState() => _SelectedCandidateListState();
}

class _SelectedCandidateListState extends State<SelectedCandidateList> {
  bool male = true;
  bool female = false;
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
  bool fullTime = false;
  bool partTime = false;
  bool weekDays = false;
  bool weekEnds = false;

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
          padding: EdgeInsets.only(left:0,right:24),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
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
             SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.only(left: 24),
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
                        width: SizeConfig.screenWidth/3,
                        padding: EdgeInsets.only(left:11,top:18 ,bottom: 18),
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
                    physics:BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            _buildProfileModalSheet(context);
                          },
                            child: _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5)
                        ),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
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

  Widget _buildCandidateContainer(String candidateName ,String candidateGender ,String candidateExperienceYears,String candidateAvailability ,String candidateCity, String imagePath , double ratings){
    return InkWell(
      onTap: null,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(left:8 ,top:19,bottom: 22 ),
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(
                width: 1,
                color: Color(0xFFEBF1F4)
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(imagePath,height: 57,width: 72,fit: BoxFit.contain,),
            ),
            SizedBox(width:12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$candidateName($candidateGender)",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    Text(
                      candidateExperienceYears,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFFF7941D),
                      ),
                    ),
                    Text(
                      "$candidateAvailability . $candidateCity",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFF717F88),
                      ),
                    ),
                  ],
                ),
                Container(width: 90,),
                Row(
                  children: [
                    Text(
                      "$ratings",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 11,
                        color: Color(0xFF717F88),
                      ),
                    ),
                    Icon(
                      Icons.ac_unit_sharp,
                      size: 18,
                      color: Color(0xFFF7941D),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildFilterModalSheet(BuildContext context){
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
                SizedBox(height: 8,),
                Expanded(
                  child: Container(
                    //height: SizeConfig.screenHeight,
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
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: (){
                                     setState((){
                                       fullTime = true;
                                       partTime = false;
                                       weekDays = false;
                                       weekEnds = false;
                                     });
                                  },
                                    icon:fullTime == false?Icon(Icons.radio_button_unchecked_rounded, size: 18,color: Color(0xFFC4C4C4),):Icon(Icons.radio_button_checked_outlined,size: 18,color: Color(0xFF00A69D),),
                                ),
                                SizedBox(width: 7.75,),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState((){
                                      fullTime = false;
                                      partTime = true;
                                      weekDays = false;
                                      weekEnds = false;
                                    });
                                  },
                                  icon:partTime== false?Icon(Icons.radio_button_unchecked_rounded, size: 18,color: Color(0xFFC4C4C4),):Icon(Icons.radio_button_checked_outlined,size: 18,color: Color(0xFF00A69D),),
                                ),
                                SizedBox(width: 7.75,),
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
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState((){
                                      fullTime = false;
                                      partTime =false;
                                      weekDays = true;
                                      weekEnds = false;
                                    });
                                  },
                                  icon:weekDays == false?Icon(Icons.radio_button_unchecked_rounded, size: 18,color: Color(0xFFC4C4C4),):Icon(Icons.radio_button_checked_outlined,size: 18,color: Color(0xFF00A69D),),
                                ),
                                SizedBox(width: 7.75,),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState((){
                                      fullTime = false;
                                      partTime =false;
                                      weekDays = false;
                                      weekEnds = true;
                                    });
                                  },
                                  icon:weekEnds== false?Icon(Icons.radio_button_unchecked_rounded, size: 18,color: Color(0xFFC4C4C4),):Icon(Icons.radio_button_checked_outlined,size: 18,color: Color(0xFF00A69D),),
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
                ),
              ],
            );
          });
        }
    );
  }
  _buildProfileModalSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setState /*You can rename this!*/){
            return Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight-150,
              child: Column(
                children: <Widget>[
//                  Image.asset("assets/icons/profile.png",width: 64, height: 64, fit:BoxFit.contain,),
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
//                    height: SizeConfig.screenHeight,
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Aderonke",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF042538),
                            ),
                          ),
                        ),

                        SizedBox(height:37),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID Number:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "HE55778",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Age:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "28",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "Female",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height:18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Origin State:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "Kaduna",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Residence:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "Lagos",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Experience:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "2 Years +",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height:18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Availability:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "Live Out",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Unique Skill(s):",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                      SizedBox(height:8),
                                      Text(
                                        "Fluent in 5 languages",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height:30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Unique Skill(s):",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                  SizedBox(height:8),
                                  Text(
                                    "Fluent in 5 languages - English, Yoruba,\nHausa, Igbo and Igala.",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF717F88),
                                    ),
                                  ),
                                  SizedBox(height:18),
                                  Text(
                                    "Reports Available:",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                  SizedBox(height:8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Identity Verification",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Criminal Record",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Medical Profile and History",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Residential Address Verification",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Guarantors Profile Verification",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Color(0xFF717F88),
                                          ),
                                          SizedBox(width:8),
                                          Text(
                                            "Work History Verification ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:18),
                                  Text(
                                    "Reports Available:",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                  SizedBox(height:8),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              size:12,
                                              color: Color(0xFF717F88),
                                            ),
                                            SizedBox(width:8),
                                            Text(
                                              "8 months at Radisson BLU Anchorage Hote",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Gelion',
                                                fontSize: 14,
                                                color: Color(0xFF717F88),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              size:12,
                                              color: Color(0xFF717F88),
                                            ),
                                            SizedBox(width:8),
                                            Text(
                                              " 4 months at Best Western Hotel Ikeja",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Gelion',
                                                fontSize: 14,
                                                color: Color(0xFF717F88),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              size:12,
                                              color: Color(0xFF717F88),
                                            ),
                                            SizedBox(width:8),
                                            Text(
                                              "12 months at Southern SUN Ikoyi.",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Gelion',
                                                fontSize: 14,
                                                color: Color(0xFF717F88),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]
                                  ),

                                ],
                              ),
                              SizedBox(height:30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FlatButton(
                                    minWidth: SizeConfig.screenWidth/1.8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    padding: EdgeInsets.only(top:18 ,bottom: 18),
                                    onPressed:(){},
                                    color: Color(0xFF00A69D),
                                    child: Text(
                                      "View Full Profile",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 16,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                  Expanded(
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
                        )
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
