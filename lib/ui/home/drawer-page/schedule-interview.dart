import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate-availability.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/purchases.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('E, d MMM, y h:mm a').format(dateTime).toString();
  }


  /// ---------- START OF PENDING SECTION ----------- ////

  /// A List to hold the all the pending purchases
  List<Purchases> _pendingCandidates = [];

  /// An Integer variable to hold the length of [_pendingCandidates]
  int _pendingCandidatesLength;

  /// This value holds the current selected pending category name
  String _selectedPendingCategory;

  /// This value holds the current selected pending category id
  String _selectedPendingCategoryId;

  /// This function returns the category name of category that has selected
  /// candidates under them
  Widget _buildPendingTabCategories(){
    List<Widget> categoriesTab = [];
    setState(() {
      for(int i = 0; i < _pendingCandidates.length; i++){
        categoriesTab.add(
          InkWell(
            onTap: (){
              setState(() {
                _selectedPendingCategory = _pendingCandidates[i].getCategory.singularName;
                _selectedPendingCategoryId = _pendingCandidates[i].id;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _selectedPendingCategory == _pendingCandidates[i].getCategory.singularName
                          ? BorderSide(color: Color(0xFF00A69D), width: 2)
                          : BorderSide.none
                  )
              ),
              child: Center(
                child: Text(
                  _pendingCandidates[i].getCategory.singularName + '(${_pendingCandidates[i].candidatePlan.length})',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: _selectedPendingCategory == _pendingCandidates[i].getCategory.singularName
                          ? Color(0xFF00A69D)
                          : Color(0xFF717F88)
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: categoriesTab
    );
  }

  /// This function returns the candidates to be selected under
  /// each category
  Map<String, Widget> _buildPendingList(){
    Map<String, Widget> categoriesList = {};
    for(int i = 0; i < _pendingCandidates.length; i++){
      List<Widget> candidateList = [];
      for(int j = 0; j < _pendingCandidates[i].candidatePlan.length; j++){
        var candidate = _pendingCandidates[i].candidatePlan[j].getCandidate;
        candidateList.add(
          InkWell(
            onTap: (){
              _buildProfileModalSheet(context, _pendingCandidates[i].id,
                  candidate,
                  false,
                  categoryId: _pendingCandidates[i].getCategory.id,
                  hirePlan: _pendingCandidates[i].candidatePlan[j].hirePlan
              );
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 13, top: 9),
              decoration: BoxDecoration(
                border: Border(
                  bottom: j == (_pendingCandidates[i].candidatePlan.length - 1)
                      ? BorderSide.none
                      : BorderSide(color: Color(0xFFEBF1F4), width: 1)
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: candidate.profileImage,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.firstName + ' ' + candidate.lastName.split('').first.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        kExperience[candidate.experience] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 12,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        kTitle[candidate.availability.title] + ' . ' + candidate.origin,
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
            ),
          ),
        );
      }
      categoriesList[_pendingCandidates[i].getCategory.singularName] = Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 4),
        margin: EdgeInsets.fromLTRB(24, 25, 23, 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEBF1F4), width: 1),
        ),
        child: Column(children: candidateList),
      );
    }
    return categoriesList;
  }

  /// A function to build the list of all the pending didates
  Widget _buildPending(){
    if(_pendingCandidates.length > 0 && _pendingCandidates.isNotEmpty){
      return Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 51,
            color: Color(0xFFDFE3E8),
            margin: EdgeInsets.only(bottom: 13),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: _buildPendingTabCategories(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _buildPendingList()[_selectedPendingCategory]
            )
          ),
        ],
      );
    }
    else if(_pendingCandidatesLength == 0){
      return _buildEmpty('You have no Pending candidate\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  /// ---------- END OF PENDING SECTION ----------- ////



  /// ---------- START OF SCHEDULED SECTION ----------- ////

  /// A List to hold the all the scheduled candidates
  List<Purchases> _scheduledCandidates = [];

  /// An Integer variable to hold the length of [_scheduledCandidates]
  int _scheduledCandidateLength;

  /// This value holds the current selected scheduled category name
  String _selectedScheduledCategory;

  /// This value holds the current selected scheduled category id
  String _selectedScheduledCategoryId;

  /// This function returns the category name of category that has selected
  /// candidates under them
  Widget _buildScheduledTabCategories(){
    List<Widget> categoriesTab = [];
    setState(() {
      for(int i = 0; i < _scheduledCandidates.length; i++){
        categoriesTab.add(
          InkWell(
            onTap: (){
              setState(() {
                _selectedScheduledCategory = _scheduledCandidates[i].getCategory.singularName;
                _selectedScheduledCategoryId = _scheduledCandidates[i].id;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _selectedScheduledCategory == _scheduledCandidates[i].getCategory.singularName
                          ? BorderSide(color: Color(0xFF00A69D), width: 2)
                          : BorderSide.none
                  )
              ),
              child: Center(
                child: Text(
                  _scheduledCandidates[i].getCategory.singularName + '(${_scheduledCandidates[i].candidatePlan.length})',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: _selectedScheduledCategory == _scheduledCandidates[i].getCategory.singularName
                          ? Color(0xFF00A69D)
                          : Color(0xFF717F88)
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: categoriesTab
    );
  }

  /// This function returns the scheduled candidates to be hired under
  /// each category
  Map<String, Widget> _buildScheduledList(){
    Map<String, Widget> categoriesList = {};
    for(int i = 0; i < _scheduledCandidates.length; i++){
      List<Widget> candidateList = [];
      for(int j = 0; j < _scheduledCandidates[i].candidatePlan.length; j++){
        var candidate = _scheduledCandidates[i].candidatePlan[j].getCandidate;
        candidateList.add(
          InkWell(
            onTap: (){
              _buildProfileModalSheet(context, _scheduledCandidates[i].id,
                  candidate,
                  _scheduledCandidates[i].candidatePlan[j].interviewed
                      && (_scheduledCandidates[i].hires != _scheduledCandidates[i].roles),
                  categoryId: _scheduledCandidates[i].getCategory.id,
                  hirePlan: _scheduledCandidates[i].candidatePlan[j].hirePlan
              );
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 13, top: 9),
              decoration: BoxDecoration(
                border: Border(
                    bottom: j == (_scheduledCandidates[i].candidatePlan.length - 1)
                        ? BorderSide.none
                        : BorderSide(color: Color(0xFFEBF1F4), width: 1)
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: candidate.profileImage,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.firstName + ' ' + candidate.lastName.split('').first.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "${kExperience[candidate.experience] ?? ''} Experience",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 12,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        kTitle[candidate.availability.title] + ' . ' + candidate.origin,
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
            ),
          ),
        );
      }
      categoriesList[_scheduledCandidates[i].getCategory.singularName] = Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 4),
        margin: EdgeInsets.fromLTRB(24, 25, 23, 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEBF1F4), width: 1),
        ),
        child: Column(children: candidateList),
      );
    }
    return categoriesList;
  }

  /// A function to build the list of all the scheduled candidates
  Widget _buildScheduled(){
    if(_scheduledCandidates.length > 0 && _scheduledCandidates.isNotEmpty){
      return Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 51,
            color: Color(0xFFDFE3E8),
            margin: EdgeInsets.only(bottom: 13),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: _buildScheduledTabCategories(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: _buildScheduledList()[_selectedScheduledCategory]
              )
          ),
        ],
      );
    }
    else if(_scheduledCandidateLength == 0){
      return _buildEmpty('You have no Scheduled candidate\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  /// ---------- END OF SCHEDULED SECTION ----------- ////



  /// ---------- START OF CONCLUDED SECTION ----------- ////

  /// A List to hold the all the concluded candidates
  List<Purchases> _concludedCandidates = [];

  /// An Integer variable to hold the length of [_concludedCandidates]
  int _concludedCandidateLength;

  /// This value holds the current selected concluded category name
  String _selectedConcludedCategory;

  /// This value holds the current selected concluded category id
  String _selectedConcludedCategoryId;

  /// This function returns the category name of category that has selected
  /// candidates under them
  Widget _buildConcludedTabCategories(){
    List<Widget> categoriesTab = [];
    setState(() {
      for(int i = 0; i < _concludedCandidates.length; i++){
        categoriesTab.add(
          InkWell(
            onTap: (){
              setState(() {
                _selectedConcludedCategory = _concludedCandidates[i].getCategory.singularName;
                _selectedConcludedCategoryId = _concludedCandidates[i].id;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _selectedConcludedCategory == _concludedCandidates[i].getCategory.singularName
                          ? BorderSide(color: Color(0xFF00A69D), width: 2)
                          : BorderSide.none
                  )
              ),
              child: Center(
                child: Text(
                  _concludedCandidates[i].getCategory.singularName + '(${_concludedCandidates[i].candidatePlan.length})',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: _selectedConcludedCategory == _concludedCandidates[i].getCategory.singularName
                          ? Color(0xFF00A69D)
                          : Color(0xFF717F88)
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: categoriesTab
    );
  }

  /// This function returns the concluded interviewed candidates to be hired under
  /// each category
  Map<String, Widget> _buildConcludedList(){
    Map<String, Widget> categoriesList = {};
    for(int i = 0; i < _concludedCandidates.length; i++){
      List<Widget> candidateList = [];
      for(int j = 0; j < _concludedCandidates[i].candidatePlan.length; j++){
        var candidate = _concludedCandidates[i].candidatePlan[j].getCandidate;
        candidateList.add(
          InkWell(
            onTap: (){
              _buildProfileModalSheet(context, _concludedCandidates[i].id,
                  candidate,
                  _concludedCandidates[i].candidatePlan[j].interviewed
                      && (_concludedCandidates[i].hires != _concludedCandidates[i].roles),
                  categoryId: _concludedCandidates[i].getCategory.id,
                  hirePlan: _concludedCandidates[i].candidatePlan[j].hirePlan
              );
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 13, top: 9),
              decoration: BoxDecoration(
                border: Border(
                    bottom: j == (_concludedCandidates[i].candidatePlan.length - 1)
                        ? BorderSide.none
                        : BorderSide(color: Color(0xFFEBF1F4), width: 1)
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: candidate.profileImage,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.firstName + ' ' + candidate.lastName.split('').first.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "${kExperience[candidate.experience] ?? ''} Experience",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 12,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        kTitle[candidate.availability.title] + ' . ' + candidate.origin,
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
            ),
          ),
        );
      }
      categoriesList[_concludedCandidates[i].getCategory.singularName] = Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 4),
        margin: EdgeInsets.fromLTRB(24, 25, 23, 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEBF1F4), width: 1),
        ),
        child: Column(children: candidateList),
      );
    }
    return categoriesList;
  }

  /// A function to build the list of all the concluded candidates
  Widget _buildConcluded(){
    if(_concludedCandidates.length > 0 && _concludedCandidates.isNotEmpty){
      return Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 51,
            color: Color(0xFFDFE3E8),
            margin: EdgeInsets.only(bottom: 13),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: _buildConcludedTabCategories(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: _buildConcludedList()[_selectedConcludedCategory]
              )
          ),
        ],
      );
    }
    else if(_concludedCandidateLength == 0){
      return _buildEmpty('You have no Concluded candidate\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  /// ---------- END OF CONCLUDED SECTION ----------- ////



  /// A function to build the empty state of a widget
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

  /// Function to fetch all the purchases from the database to
  /// respective areas
  void _allPendingPurchases() async {
    Future<List<Purchases>> list = futureValue.getAllPendingPurchases();
    await list.then((value) {
      _pendingCandidates.clear();
      _concludedCandidates.clear();
      _scheduledCandidates.clear();
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _pendingCandidatesLength = 0;
          _pendingCandidates = [];

          _scheduledCandidateLength = 0;
          _scheduledCandidates = [];

          _concludedCandidateLength = 0;
          _concludedCandidates = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          for(int i = 0; i < value.length; i++){
            if(value[i].candidatePlan.any((element) => element.interviewed && element.interviewDate.isAfter(DateTime.now()))) {
              _scheduledCandidates.add(value[i]);
            }
            else if(value[i].candidatePlan.any((element) => element.interviewed && element.interviewDate.isBefore(DateTime.now()))) {
              _concludedCandidates.add(value[i]);
            }
            else if(value[i].candidatePlan.any((element) => !element.interviewed)) {
              _pendingCandidates.add(value[i]);
            }
          }
          _pendingCandidatesLength = _pendingCandidates.length;
          if(_pendingCandidatesLength != 0){
            _selectedPendingCategory = _pendingCandidates[0].getCategory.singularName;
            _selectedPendingCategoryId = _pendingCandidates[0].id;
          }

          _scheduledCandidateLength = _scheduledCandidates.length;
          if(_scheduledCandidateLength != 0){
            _selectedScheduledCategory = _scheduledCandidates[0].getCategory.singularName;
            _selectedScheduledCategoryId = _scheduledCandidates[0].id;
          }

          _concludedCandidateLength = _concludedCandidates.length;
          if(_concludedCandidateLength != 0){
            _selectedConcludedCategory = _concludedCandidates[0].getCategory.singularName;
            _selectedConcludedCategoryId = _concludedCandidates[0].id;
          }
        });
      }
      print(_pendingCandidatesLength);
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  bool _showScheduleSpinner = false;

  bool _showSpinner = false;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        setState(() { });
      }
    });
    _allPendingPurchases();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFCFDFE),
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
          "Schedule Interview",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 19,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 270,
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.only(bottom: 32.39),
            child: Text(
              'Please schedule your preferred candidates for a date most convenient for you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 12.6829,
                color: Color(0xFF57565C),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
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
                  Tab(text: 'Pending'),
                  Tab(text: 'Scheduled'),
                  Tab(text: 'Completed'),
                ]
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: Color(0xFFC5C9CC),
          ),
          SizedBox(height: 33),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                _buildPending(),
                _buildScheduled(),
                _buildConcluded()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? Container(
        margin: EdgeInsets.fromLTRB(25, 22, 25, 30),
        child: Button(
          onTap: (){
            _showScheduleDateTime(_selectedPendingCategoryId);
          },
          buttonColor: Color(0xFF00A69D),
          height: 60,
          child: Center(
            child: _showScheduleSpinner
                ? CupertinoActivityIndicator(radius: 13)
                : Text(
              'Schedule',
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
      )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildProfileModalSheet(BuildContext context, String savedCategoryId, Candidate candidate, bool hire, {String categoryId, dynamic hirePlan}){
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
                                      "Service Area",
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
                                      kTitle[candidate.availability.title] ?? '',
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
                                      "Languages:",
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
                                        candidate.language ?? '',
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
                                      Functions.capitalize(candidate.gender) ?? '',
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
                                      kExperience[candidate.experience] ?? '',
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
                        hire
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Button(
                              onTap: (){
                                _buildHireStartSheet(context, candidate, savedCategoryId, categoryId, hirePlan);
                              },
                              buttonColor: Color(0xFF00A69D),
                              child: Center(
                                child: Text(
                                  'Hire',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextButton(
                              onPressed: (){
                                _buildRemoveSheet(context, candidate, savedCategoryId);
                              },
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFE93E3A),
                                ),
                              ),
                            ),
                          ],
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
      if (await canLaunch(url)) await launch(url);
      throw 'Could not launch the url';
    }
  }

  /// This variables holds the schedule at date to be selected
  DateTime _scheduleAt;

  /// Function to show the bottom date time picker fo selecting shedule date
  void _showScheduleDateTime(String categoryId){
    DateTime now = DateTime.now();
    DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(now.year + 1, now.month, now.day),
        onConfirm: (date) {
          if(date.weekday != 7){
            if(date.hour >= 9 && date.hour <= 15){
              if(!mounted)return;
              setState(() => _scheduleAt = date);
            }
            else {
              Functions.showError(context, "You can only schedule an interview between 9:00am to 3:00pm");
            }
          }
          else {
            Functions.showError(context, "You can't schedule an interview on a Sunday");
          }
        },
        onCancel: (){
          if(!mounted)return;
          setState(() => _scheduleAt = null);
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en
    ).then((value) {
      if(_scheduleAt != null){
        _scheduleInterview(categoryId);
      }
    });
  }

  /// Function to schedule interview by calling [scheduleCandidate] in the
  /// [RestDataSource] class
  void _scheduleInterview(String categoryId){
    if(!mounted) return;
    setState(() { _showScheduleSpinner = true; });
    var api = RestDataSource();
    api.scheduleCandidate(categoryId, _scheduleAt).then((dynamic) async{
      if(!mounted) return;
      setState(() {
        _scheduleAt = null;
        _showScheduleSpinner = false;
      });
      _allPendingPurchases();
      _buildCandidateScheduledSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setState(() {
        _showScheduleSpinner = false;
        _scheduleAt = null;
      });
      Functions.showError(context, e);
    });
  }

  /// This function shows a successful modal sheet to show candidates in a
  /// category has been scheduled for interview
  _buildCandidateScheduledSheet(BuildContext context){
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
                padding: EdgeInsets.fromLTRB(24, 33.75, 24, 38),
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
                      "Interview Scheduled",
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
                        "Your candidate(s) will be notified of the interview date. We will contact you for more details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
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
                        "Schedule For Others",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
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



  TextEditingController _scheduleController = TextEditingController();

  DateTime _resumeAt;

  _buildHireStartSheet(BuildContext context, Candidate candidate, String savedCategoryId, String categoryId, dynamic hirePlan){
    _scheduleController.clear();
    bool liveIn = candidate.availability.title == 'Live In' ? true : false;

    bool monday = false;
    bool tuesday = false;
    bool wednesday = false;
    bool thursday = false;
    bool friday = false;
    bool saturday = false;
    bool sunday = false;
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
                            'Availability - ${candidate.availability.title == 'Live In' ? 'Full Time' : 'Select Days'}',
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
                                child: TextButton(
                                    onPressed: () {
                                      setModalState(() {
                                        if(hirePlan.sunday['availability']){
                                          sunday = !sunday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.sunday['availability']
                                        ? sunday
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
                                        if(hirePlan.monday['availability']){
                                          monday = !monday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.monday['availability']
                                        ? monday
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
                                        if(hirePlan.tuesday['availability']){
                                          tuesday = !tuesday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.tuesday['availability']
                                        ? tuesday
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
                                        if(hirePlan.wednesday['availability']){
                                          wednesday = !wednesday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.wednesday['availability']
                                        ? wednesday
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
                                        if(hirePlan.thursday['availability']){
                                          thursday = !thursday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.thursday['availability']
                                        ? thursday
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
                                        if(hirePlan.friday['availability']){
                                          friday = !friday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.friday['availability']
                                        ? friday
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
                                        if(hirePlan.saturday['availability']){
                                          saturday = !saturday;
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder()
                                    ),
                                    child: hirePlan.saturday['availability']
                                        ? saturday
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
                          var availability = Availability();
                          availability.title = hirePlan.title;
                          availability.sunday = { "availability": liveIn ? true : sunday, "booked": false };
                          availability.monday = { "availability": liveIn ? true : monday, "booked": false };
                          availability.tuesday = { "availability": liveIn ? true : tuesday, "booked": false };
                          availability.wednesday = { "availability": liveIn ? true : wednesday, "booked": false };
                          availability.thursday = { "availability": liveIn ? true : thursday, "booked": false };
                          availability.friday = { "availability": liveIn ? true : friday, "booked": false };
                          availability.saturday = { "availability": liveIn ? true : saturday, "booked": false };
                          _hireCandidate(savedCategoryId, categoryId, candidate, availability, setModalState);
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
      _allPendingPurchases();
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
                        "Schedule For Others",
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

  _buildRemoveSheet(BuildContext context, Candidate candidate, String savedCategoryId){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Container(
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
                    "Remove Candidate",
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
                      "This candidate will be removed and you also have an option to add another candidate.",
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
                      _removeCandidate(savedCategoryId, candidate, setModalState);
                    },
                    buttonColor: Color(0xFFE93E3A),
                    child: Center(
                      child: _showSpinner
                          ? CupertinoActivityIndicator(radius: 13)
                          : Text(
                        "Remove",
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
                ],
              ),
            );
          });
        }
    );
  }

  void _removeCandidate(String savedCategoryId, Candidate candidate, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.deleteCandidate(savedCategoryId, candidate.id).then((dynamic) async{
      _allPendingPurchases();
      if(!mounted) return;
      setModalState(() { _showSpinner = false; });
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() { _showSpinner = false; });
      Functions.showError(context, e);
    });
  }

}
