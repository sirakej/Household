import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/schedule-interview.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/transaction-details.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'account.dart';
import 'purchases/saved-purchases.dart';

class HireCandidate extends StatefulWidget {

  static const String id = 'hire_candidates';

  @override
  _HireCandidateState createState() => _HireCandidateState();
}

class _HireCandidateState extends State<HireCandidate> with SingleTickerProviderStateMixin{

  TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// String variable to hold the current name of the user
  String _firstName;

  String _surName;

  /// Setting the current user logged in to [_firstName]
  void _getCurrentUser() async {
    await futureValue.getCurrentUser().then((user) {
      if(!mounted)return;
      setState(() {
        _firstName = user.firstName;
        _surName = user.surName;
      });
    }).catchError((e) {
      print(e);
    });
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
      Constants.showError(context, e);
    });
  }

  /// A function to build the list of all the pending hired candidates
  Widget _buildPending(){
    List<Widget> pendingContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        if(_candidates[i].status.toLowerCase() == 'pending'){
          pendingContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i].getCandidate, 'Send Review');
                },
                selected: false,
                showStars: false,
              ),
            ),
          );
        }
      }
      return pendingContainer.length > 0
          ? SingleChildScrollView(
        child: Column(
          children: pendingContainer,
        ),
      )
          : _buildEmpty('You have no Pending candidate\nat the moment');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('You have no Pending candidate\nat the moment');
    }
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        items: 20,
        period: Duration(seconds: 3),
        highlightColor: Color(0xFF1F1F1F),
        direction: SkeletonDirection.btt,
      ),
    );
  }

  /// A function to build the list of all the ongoing hired candidates
  Widget _buildOngoing(){
    List<Widget> ongoingContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        if(_candidates[i].status.toLowerCase() == 'ongoing'){
          ongoingContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){
                  _buildProfileModalSheet(context, _candidates[i].getCandidate, null);
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
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        items: 20,
        period: Duration(seconds: 3),
        highlightColor: Color(0xFF1F1F1F),
        direction: SkeletonDirection.btt,
      ),
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
                  _buildProfileModalSheet(context, _candidates[i].getCandidate, 'Rehire');
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
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        items: 20,
        period: Duration(seconds: 3),
        highlightColor: Color(0xFF1F1F1F),
        direction: SkeletonDirection.btt,
      ),
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
        ]
      )
    );
  }

  @override
  void initState(){
    _getCurrentUser();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _allHiredCandidates();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      /*drawer: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))
        ),
        child: Drawer(
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF006838),
                            Color(0xFF00A69D),
                          ],
                          stops: [0.55, 1],
                        )
                    ),
                    child: DrawerHeaderName(
                      firstName: _firstName,
                      surName: _surName,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 34, 24, 20),
                    height: SizeConfig.screenHeight * 0.6,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          children:[
                            DrawerContainer(
                              title: "My Account",
                              imageName: "account",
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return Account();
                                    })
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "Hired Candidates",
                              imageName: "hired_candidates",
                              onTap: (){
                                Navigator.pop(context);
                              },
                            ),
                            DrawerContainer(
                              title: "Transactions & Payments",
                              imageName: "transactions",
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return TransactionAndPayments();
                                    }
                                    )
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "My Purchases",
                              imageName: "my_purchases",
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return SavedPurchases();
                                    }
                                    )
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "Scheduled Interview",
                              imageName: "scheduled_interview",
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return ScheduledInterview();
                                    }
                                    )
                                );
                              },
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 35),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed:(){
                      Constants.logOut(context);
                    },
                    child: Text(
                      "Log Out",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFFE36D45),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),*/
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
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Previous'),
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
                  _buildPending(),
                  _buildPrevious(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProfileModalSheet(BuildContext context, Candidate candidate, String text){
    List<Widget> history = [];
    for(int i = 0; i < candidate.history.length; i++){
      history.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check,
              size:12,
              color: Color(0xFF717F88),
            ),
            SizedBox(width:8),
            Container(
              width: SizeConfig.screenWidth - 120,
              child: Text(
                candidate.history[i].toString(),
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
                                        fontWeight: FontWeight.w400,
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
                                      "Origin",
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
                                      "${candidate.origin ?? ''}",
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
                                      candidate.availability.title ?? '',
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
                                      "${candidate.age ?? ''}",
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
                                    Container(
                                      width: 120,
                                      child: Text(
                                        candidate.residence ?? '',
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
                                          '${candidate.rating ?? ''}',
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
                                      candidate.gender ?? '',
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
                                      "${candidate.experience} ${candidate.experience > 1 ? 'Years' : 'Year'} +",
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
                                      candidate.tribe ?? '',
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
                                    // "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
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
                            candidate.officialHeReport.isNotEmpty
                                ? TextButton(
                              onPressed: () {
                                _openUrl(candidate.officialHeReport);
                              },
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
                            )
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 30),
                        text != null
                            ? Button(
                          onTap: (){
                            Navigator.pop(context);
                            if(text == 'Send Review'){
                              _buildReviewSheet(context, candidate);
                            }
                            else if(text == 'Rehire') {

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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch the url';
    }
  }

  TextEditingController reviewController = TextEditingController();

  bool _showSpinner = false;

  _buildReviewSheet(BuildContext context, Candidate candidate){
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Container(
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
                        children:[
                          SizedBox(height: 42),
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
                          //StarDisplay(value: candidate.rating ?? 0),
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
                                _reviewCandidate(candidate.id, rating, setModalState);
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
                ],
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 30, 24, 38),
                          margin: EdgeInsets.only(top: 34),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "Review Sent",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              Center(
                                child: Text(
                                  "You have completed your hire!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
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
                              Center(
                                child: TextButton(
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
                                ),
                              )
                            ],
                          ),
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

  void _reviewCandidate(String id, int rating, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    api.reviewCandidate(id, reviewController.text.trim(), rating).then((dynamic) async{
      reviewController.clear();
      if(!mounted) return;
      setModalState(() { _showSpinner = false; });
      Navigator.pop(context);
      _buildReviewSentSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

}
