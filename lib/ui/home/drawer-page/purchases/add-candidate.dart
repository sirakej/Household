import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category-class.dart';
import 'package:householdexecutives_mobile/model/saved-candidates.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCandidate extends StatefulWidget {

  static const String id = 'add_candidates';

  final CategoryClass category;

  final  List<SavedCandidatePlan> candidates;

  final String categoryId;

  const AddCandidate({
    Key key,
    @required this.category,
    @required this.candidates,
    @required this.categoryId,
  }) : super(key: key);

  @override
  _AddCandidateState createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {

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
    Future<List<Candidate>> names = futureValue.getAllCandidateFromDB(widget.category.id);
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
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      _candidatesList.clear();
      for (int i = 0; i < _candidates.length; i++){
        if (widget.candidates.any((element) => element.getCandidate.id == _candidates[i].id)) {
          _candidatesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CandidateContainer(
                candidate: _candidates[i],
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
                candidate: _candidates[i],
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i]);
                },
                selected: false,
                showStars: true,
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

  bool _showSpinner = false;

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.category.singularName}',
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
                        imageUrl: widget.category.smallerImage,
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${widget.category.description}",
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
                      //_buildFilterModalSheet(context);
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
      floatingActionButton: (widget.candidates != null || widget.candidates.isNotEmpty)
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

  _buildProfileModalSheet(BuildContext context, Candidate candidate){
    List<Widget> history = [];
    for(int i = 0; i < candidate.history.length; i++){
      history.add(
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
                            child: Image.network(
                              candidate.profileImage,
                              width: 74,
                              height: 74,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace){
                                return Container();
                              },
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
                                      "Residence:",
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
                                        candidate.residence ?? '',
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
                                    SizedBox(height:8),
                                    Text(
                                      kExperience[candidate.experience] ?? '',
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
                                    // "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
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
                            candidate.officialHeReport.isNotEmpty
                                ? TextButton(
                              onPressed: () {
                                _openUrl(candidate.officialHeReport);
                              },
                              child:  Text(
                                "view official HE Report",
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
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 18),
                        Button(
                          onTap: (){
                            Navigator.pop(context);
                            _buildCustomAvailabilitySheet(context, candidate);
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
                        _addCandidate(candidate, setModalState);
                      }
                    },
                    buttonColor: booked
                        ? Color(0xFF00A69D)
                        : Color(0xFFC4CDD5),
                    child: _showSpinner
                        ? CupertinoActivityIndicator(radius: 13)
                        : Center(
                      child: Text(
                        "Continue",
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
                      "One Preferred Candidate Selected",
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
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    buttonColor: Color(0xFF00A69D),
                    child: Center(
                      child: Text(
                        "Home",
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
                      },
                      child:Text(
                        "View Other Candidates",
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

  void _addCandidate(Candidate candidate, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.updateCandidate(candidate, widget.categoryId).then((dynamic) async{
      if(!mounted) return;
      setModalState(() { _showSpinner = false; });
      Navigator.pop(context);
      _buildAddCandidateSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() { _showSpinner = false; });
      Functions.showError(context, e);
    });
  }

}
