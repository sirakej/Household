import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/custom_slider.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../packages.dart';

class SelectedCategory extends StatefulWidget {

  static const String id = 'selected_category';

  final Category category;

  final  List<Candidate> candidates;

  const SelectedCategory({
    Key key,
    @required this.category,
    this.candidates,
  }) : super(key: key);

  @override
  _SelectedCategoryState createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  bool selected = false;
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
  List<Candidate> _candidates = [];

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
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _candidates.addAll(value);
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
        if (widget.candidates.any((element) => element.id == _candidates[i].id)) {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _candidates[i],
                category: widget.category,
                onPressed: (){  },
                selected: true,
              ),
            ),
          );
        }
        else {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _candidates[i],
                category: widget.category,
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i]);
                },
                selected: false,
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
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              radius: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      items: 20,
      period: Duration(seconds: 2),
      highlightColor: Color(0xFF1F1F1F),
      direction: SkeletonDirection.btt,
    );
  }

  @override
  void initState() {
    _allCandidates();
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
      floatingActionButton: (widget.candidates != null)
          ? FloatingActionButton(
        onPressed: null,
        child: Center(
          child: Text(
            widget.candidates.length.toString(),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Gelion',
              fontSize: 24,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        backgroundColor: Color(0xFF00A69D),
      )
          : Container(),
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

  _buildProfileModalSheet(BuildContext context, Candidate candidate){
    bool viewProfile = false;
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 0, 24, 38),
                        margin: EdgeInsets.only(top: 34),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 89),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "${candidate.firstName}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF042538),
                                ),
                              ),
                            ),
                            SizedBox(height: 27),
                            Container(
                              height: viewProfile ? SizeConfig.screenHeight - 400 : 220,
                              child: Scrollbar(
                                thickness: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  SizedBox(height: 8),
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
                                              SizedBox(height: 18),
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
                                                  SizedBox(height: 8),
                                                  Text(
                                                    "${candidate.origin}",
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
                                              SizedBox(height: 18),
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
                                                  SizedBox(height: 8),
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
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
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
                                                    "${candidate.age}",
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
                                              SizedBox(height: 18),
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
                                              SizedBox(height: 18),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Rating:",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Gelion',
                                                      fontSize: 14,
                                                      color: Color(0xFF042538),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "3.5 ",
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: 'Gelion',
                                                          fontSize: 14,
                                                          color: Color(0xFF717F88),
                                                        ),
                                                      ),
                                                      Image.asset(
                                                          'assets/icons/star.png',
                                                          width: 18,
                                                          height: 15,
                                                          color: Color(0xFFF7941D),
                                                          fit: BoxFit.contain
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
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
                                                    "${candidate.gender}",
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
                                              SizedBox(height: 18),
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
                                                    "${candidate.experience} Years +",
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
                                        ],
                                      ),
                                      viewProfile
                                          ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
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
                                              SizedBox(height: 8),
                                              Container(
                                                width: SizeConfig.screenWidth - 120,
                                                child: Text(
//                                                  "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
                                                  "${candidate.skill}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gelion',
                                                    fontSize: 14,
                                                    color: Color(0xFF717F88),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Work History:",
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
                                          SizedBox(height: 18),
                                          Container(
                                            width:100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Verifications:",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gelion',
                                                    fontSize: 14,
                                                    color: Color(0xFF042538),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Identity",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Gelion',
                                                            fontSize: 14,
                                                            color: Color(0xFF717F88),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Colors.redAccent,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Residence",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Gelion',
                                                            fontSize: 14,
                                                            color: Color(0xFF717F88),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Colors.redAccent,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                      children: [
                                                        Text(
                                                          "Guarantors",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Gelion',
                                                            fontSize: 14,
                                                            color: Color(0xFF717F88),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Colors.redAccent,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                      children: [
                                                        Text(
                                                          "Health Status",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Gelion',
                                                            fontSize: 14,
                                                            color: Color(0xFF717F88),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Colors.redAccent,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          TextButton(
                                            onPressed: () {  },
                                            child:  Text(
                                              "view official HE Report",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.underline,
                                                fontFamily: 'Gelion',
                                                fontSize: 14,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                        ],
                                      )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton(
                                  minWidth: SizeConfig.screenWidth - 150,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 19, 0, 18),
                                  onPressed:(){
                                    if(!viewProfile){
                                      setModalState(() {
                                        viewProfile = true;
                                      });
                                    }
                                    else if(viewProfile == true){
                                      Navigator.pop(context);
                                      Navigator.pop(context, candidate);
                                    }
                                  },
                                  color: Color(0xFF00A69D),
                                  child: Text(
                                    !viewProfile
                                        ? "View Full Profile"
                                        : "Add Candidate to List",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(color: Color(0xFF00A69D),width: 1.4)
                                  ),
                                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                                  onPressed:(){},
                                  color: Color(0xFF00A69D).withOpacity(0.2),
                                  child: Image.asset(
                                      'assets/icons/heart.png',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 120,
                              height: 120,
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

  _buildMyList(BuildContext context){

    showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState){
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 50),
                    child: SingleChildScrollView(
                      physics:BouncingScrollPhysics(),
                      child: Column(
                        //children: selectedContainer,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,right:24),
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    minWidth: SizeConfig.screenWidth,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.only(top:18 ,bottom: 18),
                    onPressed:(){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_){
                            return Packages();
                          })
                      );
                    },
                    color: Color(0xFF00A69D),
                    child: Text(
                      "Proceed To Payment",
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
              ],
            );
          });
        }
    );
  }

  Widget _buildListContainer(Candidate candidate){
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                isShow = !isShow;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hire a ${widget.category.category.name}  ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE93E3A)
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gelion',
                                  fontSize: 8,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          )
                        ],),
                      AnimatedCrossFade(
                        firstChild: Icon(
                          Icons.keyboard_arrow_down,
                          size: 19,
                          color: Color(0xFF000000),
                        ),
                        secondChild: Icon(
                          Icons.keyboard_arrow_up,
                          size: 19,
                          color: Color(0xFF000000),
                        ),
                        crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 1000),
                        firstCurve: Curves.easeOutCirc,
                        secondCurve: Curves.easeOutCirc,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22),
          AnimatedCrossFade(
            firstChild: Container(
              child: Column(
                children: [
                  _buildCandidateContainer(candidate),
                  SizedBox(height: 32),
                  Center(
                    child:IconButton(
                      iconSize: 32,
                      onPressed: () {  },
                      icon: Icon(
                        Icons.add_circle,
                        color: Color(0xFF00A69D),
                      ),
                    ),
                  ),
                  SizedBox(height: 31),
                ],
              ),
            ),
            secondChild: Container(),
            crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
            duration: Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateContainer(Candidate candidate){
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(left:8, top: 19, bottom: 22, right: 8),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: true ? Color(0xFFFFFFFF) : Color(0xFFF7941D).withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            width: 1,
            color: true ? Color(0xFFEBF1F4) : Color(0xFFF7941D),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Image.asset(
                    'assets/icons/butler.png',
                    height: 57,
                    width: 72,
                    fit: BoxFit.contain
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${candidate.firstName} (${candidate.gender})",
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
                    '${candidate.experience}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFFF7941D),
                    ),
                  ),
//                  Text(
//                    "${candidate.availablity} . ${candidate.resedential}",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      //letterSpacing: 1,
//                      fontWeight: FontWeight.w400,
//                      fontFamily: 'Gelion',
//                      fontSize: 12,
//                      color: Color(0xFF717F88),
//                    ),
//                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  "3.5",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    //letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    fontSize: 11,
                    color: Color(0xFF717F88),
                  ),
                ),
              ),
              Image.asset(
                  'assets/icons/star.png',
                  width: 18,
                  height: 15,
                  color: Color(0xFFF7941D),
                  fit: BoxFit.contain
              )
            ],
          )
        ],
      ),
    );
  }

}
