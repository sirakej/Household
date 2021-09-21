import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class HireCandidate extends StatefulWidget {

  static const String id = 'hire_candidates';

  @override
  _HireCandidateState createState() => _HireCandidateState();
}

class _HireCandidateState extends State<HireCandidate> with SingleTickerProviderStateMixin{

  TabController _tabController;

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('E, d MMM, y h:mm a').format(dateTime).toString();
  }

  /// A List to hold the all the hired candidates
  List<HiredCandidates> _candidates = [];

  /// An Integer variable to hold the length of [_candidates]
  int _candidatesLength;

  /// Function to fetch all the hired candidates from the database to
  /// [_candidates]
  void _allHiredCandidates() async {
    Future<List<HiredCandidates>> list = futureValue.getAllHiredCandidatesFromDB();
    await list.then((value) {
      _candidates.clear();
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
          _candidates.addAll(value.reversed);
          _candidatesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all the ongoing hired candidates
  Widget _buildOngoing(){
    List<Widget> ongoingContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        print(_candidates[i].status);
        if(_candidates[i].status.toLowerCase() == 'ongoing'){
          ongoingContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i].getCandidate, _candidates[i].category, _candidates[i].id, 'Send Review');
                },
                selected: false,
                showStars: false,
              ),
            ),
          );
        }
      }
      return ongoingContainer.length > 0
          ? SingleChildScrollView(
        child: Column(
          children: ongoingContainer,
        ),
      )
          : _buildEmpty('You have no Ongoing candidate\nat the moment');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('You have no Ongoing candidate\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  /// A function to build the list of all the previous hired candidates
  Widget _buildPrevious(){
    List<Widget> previousContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        if(_candidates[i].status.toLowerCase() == 'previous'){
          previousContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i].getCandidate,
                      _candidates[i].category,  _candidates[i].id, 'Rehire',
                    savedCategoryId: _candidates[i].savedCategory,
                    hirePlan: _candidates[i].hirePlan,
                  );
                },
                selected: false,
                showStars: false,
              ),
            ),
          );
        }
      }
      return previousContainer.length > 0
          ? SingleChildScrollView(
        child: Column(
          children: previousContainer,
        ),
      )
          : _buildEmpty('You have no Previous candidate\nat the moment');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('You have no Previous candidate\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  Widget _buildEmpty(String description){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
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
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Gelion',
              fontSize: 14,
              color: Color(0xFF3B4A54),
            ),
          ),
          SizedBox(height: 150),
        ]
      )
    );
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _allHiredCandidates();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            //Icons.menu,
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            //_scaffoldKey.currentState.openDrawer();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Hired Candidates",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 19,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 25, 24, 0),
        child: Column(
          children: [
            TabBar(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                indicatorColor: Color(0xFF00A69D),
                isScrollable: false,
                labelColor: Color(0xFF00A69D),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                ),
                unselectedLabelColor: Color(0xFF3B4A54),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                tabs:[
                  Tab(text: 'Ongoing Hires'),
                  Tab(text: 'Previous Hires'),
                ]
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: 1,
              color: Color(0xFFC5C9CC),
            ),
            SizedBox(height: 25),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  _buildOngoing(),
                  //_buildPending(),
                  _buildPrevious(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProfileModalSheet(BuildContext context, Candidate candidate, String categoryId, String hireId, String text, {String savedCategoryId, dynamic hirePlan}){
    List<Widget> allHistory = [];
    List<Widget> history = [];
    if(candidate.history != null){
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
                              width: 100,
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
                            SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                _openUrl(candidate.officialHeReport);
                              },
                              child: Text(
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
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        text != null
                            ? Button(
                          onTap: (){
                            Navigator.pop(context);
                            if(text == 'Send Review'){
                              _buildReviewSheet(context, candidate, categoryId, hireId);
                            }
                            else if(text == 'Rehire') {
                              _buildHireStartSheet(context, candidate, savedCategoryId, categoryId, hirePlan);
                            }
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gelion',
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        )
                            : Container(),
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

  /// Function to call a number using the [url_launcher] package
  _openUrl(String url) async {
    if(url != null || url.isNotEmpty){
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch the url';
      }
    }
  }

  TextEditingController reviewController = TextEditingController();

  bool _showSpinner = false;

  _buildReviewSheet(BuildContext context, Candidate candidate, String categoryId, String hireId){
    reviewController.clear();
    final formKey = GlobalKey<FormState>();
    int rating = 0;
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(24, 42, 24, 38),
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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Text(
                        "Review Candidate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 32),
                      Container(
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
                      SizedBox(height: 8),
                      Text(
                        "${candidate.firstName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 12),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.all(0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Color(0xFFF7941D),
                          size: 8,
                        ),
                        onRatingUpdate: (rating) {
                          setModalState(() {
                            rating = rating;
                          });
                        },
                      ),
                      SizedBox(height: 23),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Review of Candidate',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 16,
                                color: Color(0xFF042538),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: SizeConfig.screenWidth,
                              child: TextFormField(
                                controller: reviewController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Give us a review';
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
                                    hintText: 'Your message here...',
                                    hintStyle:TextStyle(
                                      color:Color(0xFF717F88),
                                      fontSize: 14,
                                      fontFamily: 'Gelion',
                                      fontWeight: FontWeight.w400,
                                    )
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                      SizedBox(height: 32),
                      Button(
                        onTap: (){
                          if(formKey.currentState.validate() && !_showSpinner){
                            _reviewCandidate(candidate.id, categoryId, rating, hireId, setModalState);
                          }
                        },
                        buttonColor: Color(0xFF00A69D),
                        child: Center(
                          child: _showSpinner
                              ? CupertinoActivityIndicator(radius: 13)
                              : Text(
                            "Send",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            );
          });
        }
    );
  }

  _buildReviewSentSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 30, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                    SizedBox(height: 24.75),
                    Text(
                      "Review Sent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      "You have completed your hire!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    SizedBox(height: 30),
                    Button(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child:Text(
                        "Review other candidates",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }

  void _reviewCandidate(String candidateId, String categoryId, int rating,
      String hireId, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.reviewCandidate(candidateId, categoryId, hireId, reviewController.text.trim(),
        rating).then((dynamic) async{
      reviewController.clear();
      if(!mounted) return;
      setModalState(() { _showSpinner = false; });
      Navigator.pop(context);
      _buildReviewSentSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() { _showSpinner = false; });
      Functions.showError(context, e);
    });
  }


  TextEditingController _scheduleController = TextEditingController();

  DateTime _resumeAt;

  _buildHireStartSheet(BuildContext context, Candidate candidate, String savedCategoryId, String categoryId, dynamic hirePlan){
    _scheduleController.clear();
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 45, 24, 38),
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
                      "Resumption Date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: SizeConfig.screenWidth - 150,
                      child: Text(
                        "Your candidate(s) will be informed of the resumption date. We will contact you to firm up final arrangements.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Availability',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF042538),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                              Expanded(
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
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 16,
                                color: Color(0xFF042538),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: SizeConfig.screenWidth,
                              child: TextFormField(
                                controller: _scheduleController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please select';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: (){
                                  _showDateTime(setModalState);
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  color: Color(0xFF042538),
                                ),
                                decoration: kFieldDecoration.copyWith(
                                  hintText: 'Please Select',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF717F88),
                                    fontSize: 14,
                                    fontFamily: 'Gelion',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  suffixIcon: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 16,
                                            maxHeight: 16,
                                          ),
                                          width: 16,
                                          height: 16,
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Color(0xFF000000),
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 40),
                    Button(
                      onTap: (){
                        if(formKey.currentState.validate()){
                          _hireCandidate(savedCategoryId, categoryId, candidate, hirePlan, setModalState);
                        }
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: _showSpinner
                            ? CupertinoActivityIndicator(radius: 13)
                            : Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            );
          });
        }
    );
  }

  /// Function to show the bottom date time picker fo selecting frequency time
  void _showDateTime(StateSetter setModalState){
    DateTime now = DateTime.now();
    DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(now.year + 1, now.month, now.day),
        onChanged: (date) {
          if(!mounted)return;
          setModalState(() {
            _scheduleController.text = _getFormattedDate(date);
            _resumeAt = date;
          });
        },
        onConfirm: (date) {
          if(!mounted)return;
          setModalState(() {
            _scheduleController.text = _getFormattedDate(date);
            _resumeAt = date;
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en
    );
  }

  void _hireCandidate(String savedCategoryId, String categoryId,
      Candidate candidate, dynamic hirePlan, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.hireCandidate(savedCategoryId, categoryId, candidate,
        _resumeAt, hirePlan).then((dynamic) async{
      if(!mounted) return;
      setModalState(() {
        _resumeAt = null;
        _showSpinner = false;
      });
      _allHiredCandidates();
      Navigator.pop(context);
      _buildCompletedHireSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() {
        _showSpinner = false;
        _resumeAt = null;
      });
      Functions.showError(context, e);
    });
  }

  _buildCompletedHireSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 30, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                    SizedBox(height: 24.75),
                    Text(
                      "Success",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      "You have completed your hire!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
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
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:Text(
                        "Hire Others",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }

}
