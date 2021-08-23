import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate-availability.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/custom-slider.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class SelectedCategory extends StatefulWidget {

  static const String id = 'selected_category';

  final Availability availability;

  final Category category;

  final  List<Candidate> candidates;

  const SelectedCategory({
    Key key,
    this.availability,
    @required this.category,
    this.candidates,
  }) : super(key: key);

  @override
  _SelectedCategoryState createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {

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
    "0 - 2",
    "2 - 5",
    "5 - 10",
    "10 - ",
  ];


  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A List to hold the all the candidates
  List<Candidate> _candidates = [];

  /// A List to hold the all the filtered candidates
  List<Candidate> _filteredCandidates = [];

  /// An Integer variable to hold the length of [_candidates]
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
          _filteredCandidates = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _candidates.addAll(value);
          _filteredCandidates.addAll(value);
          _candidatesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      _candidatesList.clear();
      for (int i = 0; i < _filteredCandidates.length; i++){
        if (widget.candidates.any((element) => element.id == _filteredCandidates[i].id)) {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _filteredCandidates[i],
                category: widget.category,
                onPressed: (){},
                selected: true,
                showStars: true,
              ),
            ),
          );
        }
        else {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _filteredCandidates[i],
                category: widget.category,
                onPressed: (){
                  _buildProfileModalSheet(context, _filteredCandidates[i]);
                },
                selected: false,
                showStars: true,
              ),
            ),
          );
        }
      }
      return _candidatesList.length > 0
          ? Column(children: _candidatesList)
          : _buildEmpty('Sorry there is no available candidates in this category with your preference');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('Sorry there is no available candidates in this category at the moment');
    }
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: Colors.white.withOpacity(0.5),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
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
      direction: SkeletonDirection.ltr,
    );
  }

  Widget _buildEmpty(String description){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          SizedBox(height: 50),
          Image.asset(
              'assets/icons/empty.png',
              width: 143,
              height: 108,
              fit: BoxFit.contain
          ),
          SizedBox(height: 24),
          Text(
            "Empty List",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Gelion',
              fontSize: 19,
              color: Color(0xFF000000),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: 280,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF3B4A54),
              ),
            ),
          ),
        ]
      )
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.category.category.pluralName}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gelion',
                              fontSize: 19,
                              color: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(width: 5),
                          CachedNetworkImage(
                            imageUrl: widget.category.category.smallerImage,
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => Container(),
                          ),
                        ],
                      ),
                      (widget.candidates != null || widget.candidates.isNotEmpty)
                          ? TextButton(
                        onPressed: (){
                          if(widget.candidates.length > 0){
                            Navigator.pop(context, [true, widget.candidates]);
                          }
                        },
                        child: Text(
                          'Checkout(${widget.candidates.length})',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF00A69D),
                          ),
                        ),
                      )
                          : Container()
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${widget.category.category.description}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF57565C),
                    ),
                  ),
                  SizedBox(height: 32),
                  InkWell(
                    onTap: (){
                     _buildFilterModalSheet(context);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(11, 18, 14, 18),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A69D).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1,
                            color: Color(0xFF00A69D)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/icons/Filter.png",
                            height: 20,
                            width: 20,
                            fit:BoxFit.contain
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Filter Results",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF00A69D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: _buildList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _male = true;
  bool _female = false;

  bool _liveIn = false;
  bool _custom = true;

  double _lowerValue = 20;
  double _upperValue = 50;

  Map<String, dynamic> _filteredData = {};

  _buildFilterModalSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState){
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
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 19, 24, 38),
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
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setModalState(() {
                                  _male = true;
                                  _female = false;
                                });
                              },
                              child: Container(
                                width: 91,
                                padding: EdgeInsets.only(top:18 ,bottom: 18),
                                decoration: BoxDecoration(
                                    color: _male ? Color(0xFF00A69D).withOpacity(0.2) : Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: _male ? 1.4 : 1,
                                      color: _male ? Color(0xFF00A69D) : Color(0xFFEBF1F4),
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    "Male",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: _male ? Color(0xFF00A69D) : Color(0xFF717F88),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 11),
                            InkWell(
                              onTap: (){
                                setModalState(() {
                                  _male = false;
                                  _female = true;
                                });
                              },
                              child: Container(
                                width: 91,
                                padding: EdgeInsets.only(top:18 ,bottom: 18),
                                decoration: BoxDecoration(
                                    color: _female ? Color(0xFF00A69D).withOpacity(0.2) : Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: _female ? 1.4 : 1,
                                      color: _female ? Color(0xFF00A69D) : Color(0xFFEBF1F4),
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    "Female",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: _female ? Color(0xFF00A69D) : Color(0xFF717F88),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
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
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
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
                                      setModalState(() {
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
                            SizedBox(width: 10),
                            Column(
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
                                      setModalState(() {
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
                          ],
                        ),
                        SizedBox(height: 24),
                        Column(
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
                                value: _selectedExperience,
                                onChanged: (String value){
                                  if(!mounted)return;
                                  setModalState(() {
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
                                      '$value ${value == '10 - ' ? 'above' : 'years'}',
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
                                      '$value ${value == '10 - ' ? 'above' : 'years'}',
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
                        SizedBox(height: 27),
                        Text(
                          "Age Range",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
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
                            setModalState(() {});
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
                        SizedBox(height: 20),
                        Text(
                          "Availability",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            TextButton(
                              onPressed: (){
                                setModalState((){
                                  _liveIn = true;
                                  _custom = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                      _liveIn
                                          ? Icons.radio_button_checked_outlined
                                          : Icons.radio_button_unchecked_rounded,
                                      size: 18,
                                      color: _liveIn ? Color(0xFF00A69D) : Color(0xFFC4C4C4)
                                  ),
                                  SizedBox(width: 7.75),
                                  Text(
                                    "Live in",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: (){
                                setModalState((){
                                  _custom = true;
                                  _liveIn = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                      _custom
                                          ? Icons.radio_button_checked_outlined
                                          : Icons.radio_button_unchecked_rounded,
                                      size: 18,
                                      color: _custom ? Color(0xFF00A69D) : Color(0xFFC4C4C4)
                                  ),
                                  SizedBox(width: 7.75),
                                  Text(
                                    "Live Out",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
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
                        SizedBox(height: 37),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button(
                              onTap: (){
                                setState(() {
                                  _filteredData.clear();
                                  _filteredCandidates = _candidates;
                                  _filteredData['gender'] = _male ? 'Male' : 'Female';
                                  _filteredData['availability'] = _liveIn ? 'Live In' : 'Custom';
                                  _filteredData['age'] = '$_lowerValue - $_upperValue';
                                  _filteredData['tribe'] = _selectedTribe;
                                  _filteredData['religion'] = _selectedReligion;
                                  _filteredData['experience'] = _selectedExperience;
                                });

                                Navigator.pop(context);
                                _filterCandidates();
                              },
                              buttonColor: Color(0xFF00A69D),
                              width: SizeConfig.screenWidth / 1.5,
                              padding: 18,
                              child: Center(
                                child: Text(
                                  "Show Results",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed:(){
                                  setState(() {
                                    _filteredCandidates = _candidates;
                                    _filteredData.clear();
                                  });
                                  setModalState(() {
                                    _lowerValue = 20; _upperValue = 50;
                                    _selectedReligion = null;
                                    _selectedExperience = null;
                                    _selectedTribe = null;
                                    _female = false; _male = true;
                                    _custom = true; _liveIn = false;
                                  });
                                },
                                child: Text(
                                  "Clear",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
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

  void _filterCandidates(){
    List<Candidate> temp = [];
    List<String> age = _filteredData["age"].split(' - ');
    List<String> experience = _filteredData["experience"].split(' - ');
    for(int i = 0; i < _filteredCandidates.length; i++) {
      if (_filteredCandidates[i].tribe == _filteredData["tribe"]
          && _filteredCandidates[i].gender == _filteredData["gender"]
          && _filteredCandidates[i].religion == _filteredData["religion"]
          && _filteredCandidates[i].availability.title ==
              _filteredData["availability"]
          && _filteredCandidates[i].age >= double.parse(age[0].toString())
          && _filteredCandidates[i].age <= double.parse(age[1].toString())
          && _filteredCandidates[i].experience >= int.parse(experience[0])
          && (experience.length == 2
              ? _filteredCandidates[i].experience <= int.parse(experience[1])
              : true)
      ) {
        temp.add(_filteredCandidates[i]);
      }
    }
    if(!mounted)return;
    setState(() { _filteredCandidates = temp; });
  }

  _buildProfileModalSheet(BuildContext context, Candidate candidate){
    List<Widget> allHistory = [];
    List<Widget> history = [];
    for(int i = 0; i < candidate.history.length; i++){
      allHistory.add(
        Container(
          width: SizeConfig.screenWidth - 120,
          child: Text(
            '• ${candidate.history[i].toString()}',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Gelion',
              fontSize: 14,
              color: Color(0xFF717F88),
            ),
          ),
        ),
      );
    }
    if(allHistory.length <= 2){
      history.addAll(allHistory);
    }
    else {
      history.add(allHistory[0]);
      history.add(allHistory[1]);
    }
    showModalBottomSheet<void>(
        backgroundColor: Color(0xFFFFFFFF),
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Color(0xFF000000),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    'Candidates Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 19,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 74,
                            height: 74,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFF717F88), width: 0.5)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: CachedNetworkImage(
                                imageUrl: candidate.profileImage,
                                width: 74,
                                height: 74,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
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
                        SizedBox(height: 37),
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'HE${candidate.id.substring(0, 6).toUpperCase()}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                      "Service Area",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${candidate.origin ?? ''}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      kTitle[candidate.availability.title] ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      "${candidate.age ?? ''}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                      "Languages:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        candidate.language ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
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
                                      "Rating:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '${candidate.rating ?? ''}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      Functions.capitalize(candidate.gender) ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      kExperience[candidate.experience]  ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      candidate.tribe ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
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
                        Column(
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
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  width: SizeConfig.screenWidth - 120,
                                  child: Text(
                                    "${candidate.skill}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
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
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: history,
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
                                      fontWeight: FontWeight.normal,
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
                                              fontWeight: FontWeight.normal,
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
                                              fontWeight: FontWeight.normal,
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
                                              fontWeight: FontWeight.normal,
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
                                              fontWeight: FontWeight.normal,
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
                            SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                //_openUrl(candidate.officialHeReport);
                              },
                              child:  Text(
                                "View official HE Report",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        Button(
                          onTap: (){
                            setModalState(() {
                              if(!(widget.candidates.contains(candidate))){
                                widget.candidates.add(candidate);
                              }
                            });
                            Navigator.pop(context);
                            _buildAddCandidateSheet(context);
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                            child: Text(
                              "Add Candidate to List",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 38),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }
    );
  }

  _buildCustomAvailabilitySheet(BuildContext context, Candidate candidate){
    int language = 0;
    List<String> lang = candidate.language.split(',');
    lang.forEach((e) {
      if(e.trim().isNotEmpty){
        language += 1;
      }
    });
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            bool booked = false;
            if(candidate.availability.sunday['booked']
                || candidate.availability.monday['booked']
                || candidate.availability.tuesday['booked']
                || candidate.availability.wednesday['booked']
                || candidate.availability.thursday['booked']
                || candidate.availability.friday['booked']
                || candidate.availability.saturday['booked']){
              setModalState(() {
                booked = true;
              });
            }
            return Container(
              padding: EdgeInsets.fromLTRB(24, 56, 24, 38),
              margin: EdgeInsets.only(top: 34),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(30),
                  topRight:Radius.circular(30)
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Text(
                    "Candidate Added",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 16,
                      color: Color(0xFF042538),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Fluent in $language language(s) - ${candidate.language}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF57565C),
                    ),
                  ),
                  SizedBox(height: 44),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.sunday['availability']){
                                candidate.availability.sunday['booked']
                                = !candidate.availability.sunday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.sunday['availability']
                              ? candidate.availability.sunday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sun",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Sun",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Sun",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.monday['availability']){
                                candidate.availability.monday['booked']
                                = !candidate.availability.monday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.monday['availability']
                              ? candidate.availability.monday['booked']
                                ? Container(
                              height:33,
                              width: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF00A69D).withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "Mon",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF00A69D),
                                  ),
                                ),
                              )
                          )
                                : Text(
                            "Mon",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF000000),
                            ),
                          )
                              : Text(
                            "Mon",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFFC4CDD5),
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.tuesday['availability']){
                                candidate.availability.tuesday['booked']
                                = !candidate.availability.tuesday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.tuesday['availability']
                              ? candidate.availability.tuesday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Tue",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Tue",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Tue",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.wednesday['availability']){
                                candidate.availability.wednesday['booked']
                                = !candidate.availability.wednesday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.wednesday['availability']
                              ? candidate.availability.wednesday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Wed",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Wed",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Wed",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.thursday['availability']){
                                candidate.availability.thursday['booked']
                                = !candidate.availability.thursday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.thursday['availability']
                              ? candidate.availability.thursday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Thu",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Thu",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Thu",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.friday['availability']){
                                candidate.availability.friday['booked']
                                = !candidate.availability.friday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.friday['availability']
                              ? candidate.availability.friday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Fri",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Fri",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Fri",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setModalState(() {
                              if(candidate.availability.saturday['availability']){
                                candidate.availability.saturday['booked']
                                = !candidate.availability.saturday['booked'];
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder()
                          ),
                          child: candidate.availability.saturday['availability']
                              ? candidate.availability.saturday['booked']
                                ? Container(
                                height:33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A69D).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sat",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF00A69D),
                                    ),
                                  ),
                                )
                            )
                                : Text(
                              "Sat",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF000000),
                              ),
                            )
                              : Text(
                              "Sat",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFC4CDD5),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 49),
                  Button(
                    onTap: (){
                      if(booked){
                        setModalState(() {
                          if(!(widget.candidates.contains(candidate))){
                            widget.candidates.add(candidate);
                          }
                        });
                        Navigator.pop(context);
                        _buildAddCandidateSheet(context);
                      }
                    },
                    buttonColor: booked
                        ? Color(0xFF00A69D)
                        : Color(0xFFC4CDD5),
                    child: Center(
                      child: Text(
                        "Check Out",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            );
          });
        }
    );
  }

  _buildAddCandidateSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Container(
              padding: EdgeInsets.fromLTRB(24, 30, 24, 38),
              margin: EdgeInsets.only(top: 34),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Center(
                    child:Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                  ),
                  SizedBox(height: 24.75),
                  Center(
                    child: Text(
                      "Candidate Added",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
                  Center(
                    child: Text(
                      "Please remember that you are permitted to pick a maximum of 3 candidates for this category",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Button(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context, [true, widget.candidates]);
                    },
                    buttonColor: Color(0xFF00A69D),
                    child: Center(
                      child: Text(
                        "Continue to Check Out",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        setState(() { });
                      },
                      child:Text(
                        "Select Another Candidate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        }
    );
  }

  /// Function to call a number using the [url_launcher] package
  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch the url';
    }
  }

}
