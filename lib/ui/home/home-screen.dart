import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/popular-category.dart';
import 'package:householdexecutives_mobile/ui/candidate/find-category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer-page/account.dart';
import 'drawer-page/hired-candidate.dart';
import 'drawer-page/purchases/saved-purchases.dart';
import 'drawer-page/transaction-details.dart';
import 'drawer-page/schedule-interview.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class HomeScreen extends StatefulWidget {

  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();

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

  /// A List to hold the all the popular categories
  List<PopularCategory> _popularCategories = [];

  /// Variable of List<[Category]> to hold all the filtered popular categories
  List<PopularCategory> _filteredPopularCategories = [];

  /// An Integer variable to hold the length of [_popularCategories]
  int _popularCategoriesLength;

  /// [allCategories]
  void _allPopularCategories({bool refresh}) async {
    Future<List<PopularCategory>> names = futureValue.getPopularCategoryFromDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _popularCategoriesLength = 0;
          _popularCategories = [];
          _filteredPopularCategories = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _popularCategories.addAll(value);
          _filteredPopularCategories = _popularCategories;
          _popularCategoriesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      if(e == 'No Internet Connection'){
        _allPopularCategories(refresh: false);
      }
      else {
        Functions.showError(context, e);
      }
    });
  }

  /// A function to build the list of all the popular categories
  Widget _buildPopularCategories() {
    List<Widget> categoriesList = [];
    if(_popularCategories.length > 0 && _popularCategories.isNotEmpty){
      for (int i = 0; i < _filteredPopularCategories.length; i++){
        categoriesList.add(
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  CupertinoPageRoute(builder: (_){
                    //return SelectedList();
                    return FindACategory();
                  })
              ).then((value) {
                _getList();
              });
            },
            child: Container(
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
              margin: EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: _filteredPopularCategories[i].category.smallerImage,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Container(),
                  ),
                  SizedBox(width: 6),
                  Text(
                    _filteredPopularCategories[i].category.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF042538),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: categoriesList,
        ),
      );
    }
    else if(_popularCategoriesLength == 0){
      return Container(height: 20);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  height: 20,
                  width: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A List to hold the all the recommended candidates
  List<Candidate> _recommendedCandidates = [];

  /// Variable of List<[Candidate]> to hold all the filtered recommended candidates
  List<Candidate> _filteredRecommendedCandidates = [];

  /// An Integer variable to hold the length of [_recommendedCandidates]
  int _recommendedCandidatesLength;

  void _allRecommendedCandidates({bool refresh}) async {
    Future<List<Candidate>> names = futureValue.getRecommendedCandidates();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _recommendedCandidatesLength = 0;
          _recommendedCandidates = [];
          _filteredRecommendedCandidates = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _recommendedCandidates.addAll(value);
          _filteredRecommendedCandidates = _recommendedCandidates;
          _popularCategoriesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      if(e == 'No Internet Connection'){
        _allRecommendedCandidates(refresh: false);
      }
      else {
        Functions.showError(context, e);
      }
    });
  }

  /// A function to build the list of all the recommended candidates
  Widget _buildRecommendedCandidates() {
    List<Widget> recommendedCandidatesList = [];
    double width = 160;
    if(SizeConfig.screenWidth >= 392) width = 160;
    else width = (SizeConfig.screenWidth / 2) - 48;
    if(_recommendedCandidates.length > 0 && _recommendedCandidates.isNotEmpty){
      recommendedCandidatesList.clear();
      for (int i = 0; i < _filteredRecommendedCandidates.length; i++){
        recommendedCandidatesList.add(
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_){
                      //return SelectedList();
                      return FindACategory();
                    })
                ).then((value) {
                  _getList();
                });
              },
              child: Container(
                width: width,
                height: 125,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: _filteredRecommendedCandidates[i].recommendedCategory.image,
                          width: width,
                          height: 107,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: width,
                        height: 52,
                        padding: EdgeInsets.fromLTRB(10, 6.17, 10, 11),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _filteredRecommendedCandidates[i].recommendedCategory.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 13,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                Text(
                                  _filteredRecommendedCandidates[i].firstName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 12,
                                    color: Color(0xFF717F88),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _filteredRecommendedCandidates[i].rating.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 12,
                                    color: Color(0xFF717F88),
                                  ),
                                ),
                                Image.asset(
                                    "assets/icons/star.png",
                                    width: 10,
                                    height: 8.81,
                                    fit: BoxFit.contain
                                )
                              ],
                            ),
                          ],
                        ) ,
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      }
      /*List<Widget> _firstRow = [];
      List<Widget> _secondRow = [];
      int half = (recommendedCandidatesList.length / 2).round();
      for(int i = 0; i < half; i++){
        _firstRow.add(recommendedCandidatesList[i]);
      }
      for(int i = half; i < recommendedCandidatesList.length; i++){
        _secondRow.add(recommendedCandidatesList[i]);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(child: Row(children: _firstRow)),
          SizedBox(height: 14.94),
          SingleChildScrollView(child: Row(children: _secondRow))
        ],
      );*/
      return Wrap(
        spacing: 12,
        runSpacing: 18,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: recommendedCandidatesList,
      );
    }
    else if(_recommendedCandidatesLength == 0){
      return Container(height: width);
    }
    return Container(
      padding: EdgeInsets.only(top: 100, bottom: 100),
      child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  int _shortlistedCandidates = 0;

  /// This function fetches user's shortlisted candidates from shared
  /// preference then stores the number of candidates to [_shortlistedCandidates]
  void _getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String checkoutCategory = prefs.getString('checkoutCategory');
    String checkoutCandidates = prefs.getString('checkoutCandidates');
    if(checkoutCategory != null && checkoutCandidates != null){
      var rest = jsonDecode(checkoutCandidates) as List;
      if(!mounted)return;
      setState(() {
        _shortlistedCandidates = 0;
        for(int i = 0; i < rest.length; i++){
          if(rest[i].length != 0){
            _shortlistedCandidates += rest[i].length;
          }
        }
      });
    }
    else {
      if(!mounted)return;
      setState(() {
        _shortlistedCandidates = 0;
      });
    }
  }

  /// This function removes the saved shortlisted candidates stored in shared
  /// preference
  void _removeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('checkoutCategory');
    await prefs.remove('checkoutCandidates');
  }

  @override
  void initState() {
    _getCurrentUser();
    _getList();
    super.initState();
    _allPopularCategories(refresh: true);
    _allRecommendedCandidates(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 20,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Welcome $_firstName",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Gelion',
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
        /*actions: [
          IconButton(
            onPressed: (){

            },
            icon: Image.asset(
              "assets/icons/notification_baseline.png",
              height: 24,
              width: 24,
              fit: BoxFit.contain
            )
          )
        ],*/
      ),
      drawer: Container(
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
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_){
                            return Account();
                          }
                          )
                      );
                    },
                    child: DrawerHeader(
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFFFFF),
                              border: Border.all(
                                color: Color(0xFF5D6970),
                                width: 1.5
                              )
                            ),
                            child: (_surName != null && _firstName != null)
                                ? Center(
                              child: Text(
                                Functions.profileName('$_surName $_firstName'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gelion',
                                  fontSize: 24,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            )
                                : Container(),
                          ),
                          /*Center(
                            child: Image.asset(
                              "assets/icons/profile.png",
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain
                            )
                          ),*/
                          SizedBox(width: 13),
                          Text(
                            "${_firstName ?? ''} ${_surName ?? ''}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
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
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return Account();
                                    }
                                    )
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "Hired Candidates",
                              imageName: "hired_candidates",
                              onTap: (){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return HireCandidate();
                                    }
                                    )
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "My List",
                              imageName: "my_list",
                              number: _shortlistedCandidates,
                              onTap: (){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return FindACategory(
                                          hasList: _shortlistedCandidates > 0
                                              ? true : false
                                      );
                                    })
                                ).then((value) {
                                  _getList();
                                });
                              },
                            ),
                            DrawerContainer(
                              title: "Transactions & Payments",
                              imageName: "transactions",
                              onTap: (){
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
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return SavedPurchases();
                                    })
                                );
                              },
                            ),
                            DrawerContainer(
                              title: "Scheduled Interview",
                              imageName: "scheduled_interview",
                              onTap: (){
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
                      _removeList();
                      Functions.logOut(context);
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
      ),
      backgroundColor: Color(0xFFF3F6F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        icon:Icon(
                          Icons.menu,
                          size: 20,
                          color: Color(0xFF000000),
                        )
                      ),
                      SizedBox(width:16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, ${_firstName ?? ''}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            '', //"Maryland, Lagos",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 12,
                              color: Color(0xFF00A69D),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){},
                      child: Image.asset(
                        "assets/icons/notification_baseline.png",
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain
                      )
                  )
                ],
              ),*/
              //SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 22),
                     // _buildSearch(),
                      //SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Categories",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF6F8A9C),
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (_){
                                    //return SelectedList();
                                    return FindACategory();
                                  })
                              ).then((value) {
                                _getList();
                              });
                            },
                            child: Text(
                              "see all",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF00A69D),
                              ),
                            ),
                          )
                        ],
                      ),
                      _buildPopularCategories(),
                      SizedBox(height: 20),
                      Text(
                        "Recommended Candidates",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF6F8A9C),
                        ),
                      ),
                      SizedBox(height: 18),
                      _buildRecommendedCandidates(),
                      /*Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildRecommendedContainer("assets/icons/caterer.png","Chef", "Funke", 3.5),
                              SizedBox(width: 50),
                              _buildRecommendedContainer("assets/icons/home_plumber.png","Plumber", "Michelle", 3.5),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildRecommendedContainer("assets/icons/home_electrician.png","Electrician", "Taiwo", 3.5),
                              SizedBox(width: 50,),
                              _buildRecommendedContainer("assets/icons/home_carpenter.png","Carpenter", "Dauda", 3.5),
                            ],
                          ),
                        ],
                      ),*/
                      SizedBox(height: 5),
                      Center(
                        child: TextButton(
                            onPressed:(){
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (_){
                                    return FindACategory();
                                  })
                              ).then((value) {
                                _getList();
                              });
                            },
                            child: Text(
                              "see all candidates",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF00A69D),
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 7),
                      Center(
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Image.asset(
                                  "assets/icons/ads.png",
                                  fit: BoxFit.contain,
                                  width: 327,
                                  height: 96
                                )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(27, 5, 0, 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Peace of Mind',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gelion',
                                        fontSize: 19,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Every service required for the proper\nmaintenance and upkeep of your\nhome is covered.",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color:Color(0xFF717F88).withOpacity(0.1),
            width: SizeConfig.screenWidth,
            child: TextFormField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              //textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                color: Color(0xFF042538),
              ),
              decoration:kFieldDecoration.copyWith(
                  hintText: 'Search keywords...',
                  suffixIcon: Icon(Icons.search , color:Color(0xFF6F8A9C), size: 18,),
                  hintStyle:TextStyle(
                    color:Color(0xFF6F8A9C),
                    fontSize: 14,
                    fontFamily: 'Gelion',
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

}
