import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/scheduled-candidates.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'account.dart';
import 'hired-candidate.dart';
import 'purchases/saved-purchases.dart';
import 'transaction-details.dart';

class ScheduledInterview extends StatefulWidget {

  static const String id = 'scheduled_interview';

  @override
  _ScheduledInterviewState createState() => _ScheduledInterviewState();
}

class _ScheduledInterviewState extends State<ScheduledInterview> with SingleTickerProviderStateMixin{

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

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    if(dateTime == null) return '';
    return DateFormat('d.L.y').format(dateTime).toString().toUpperCase();
  }

  /// A List to hold the all the hired candidates
  List<ScheduledCandidates> _candidates = [];

  /// An Integer variable to hold the length of [_candidates]
  int _candidatesLength;

  /// Function to fetch all the hired candidates from the database to
  /// [_candidates]
  void _allScheduledCandidates() async {
    Future<List<ScheduledCandidates>> list = futureValue.getAllScheduledCandidatesFromDB();
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

  /// A function to build the list of all the scheduled candidates
  Widget _buildScheduled(){
    List<Widget> scheduledContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        if(_candidates[i].status.toLowerCase() == 'scheduled'){
          scheduledContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){

                },
                selected: false,
                showStars: false,
                date: _getFormattedDate(_candidates[i].schedule),
              ),
            ),
          );
        }
      }
      return scheduledContainer.length > 0
          ? SingleChildScrollView(
        child: Column(
          children: scheduledContainer,
        ),
      )
          : _buildEmpty('You have no Scheduled candidate\nat the moment');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('You have no Scheduled candidate\nat the moment');
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

  /// A function to build the list of all the finished scheduled candidates
  Widget _buildFinished(){
    List<Widget> finishedContainer = [];
    if(_candidates.length > 0 && _candidates.isNotEmpty){
      for (int i = 0; i < _candidates.length; i++){
        if(_candidates[i].status.toLowerCase() == 'finished'){
          finishedContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: _candidates[i].getCandidate,
                onPressed: (){

                },
                selected: false,
                showStars: false,
                date: _getFormattedDate(_candidates[i].schedule),
              ),
            ),
          );
        }
      }
      return finishedContainer.length > 0
          ? SingleChildScrollView(
        child: Column(
          children: finishedContainer,
        ),
      )
          : _buildEmpty('You have no Finished candidate\nat the moment');
    }
    else if(_candidatesLength == 0){
      return _buildEmpty('You have no Finished candidate\nat the moment');
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
    _tabController = TabController(length: 2, vsync: this);
    _allScheduledCandidates();
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
                    )
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
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return HireCandidate();
                                    }
                                    )
                                );
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
          "Scheduled Candidates",
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
                  Tab(text: 'Scheduled'),
                  Tab(text: 'Finished'),
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
                  _buildScheduled(),
                  _buildFinished()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
