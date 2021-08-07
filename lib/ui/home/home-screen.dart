import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/ad-banner.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/model/purchases.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/ui/candidate/find-category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer-page/account.dart';
import 'drawer-page/hired-candidate.dart';
import 'drawer-page/transaction-details.dart';
import 'drawer-page/schedule-interview.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class HomeScreen extends StatefulWidget {

  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  /// A boolean variable to hold if there are pending candidates to schedule
  /// interview for pending shortlisted candidates
  bool _pendingItems = false;

  /// A List to hold the all the categories
  List<Category> _allCategories = [];

  /// A Map to hold the all the categories id mapped to their singular name
  Map<String, String> _categoriesIdName = {};

  /// An Integer variable to hold the length of [_allCategories]
  int _allCategoriesLength;

  /// Function to fetch all the categories from the database to
  /// [_allCategories]
  void _getAllCategories({bool refresh}) async {
    Future<List<Category>> names = futureValue.getAllCategoryFromDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _allCategoriesLength = 0;
          _allCategories = [];
          _categoriesIdName = {};
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          for(int i = 0; i < value.length; i++){
            _categoriesIdName[value[i].category.id] = value[i].category.singularName;
            _allCategories.add(value[i]);
          }
          _allCategoriesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      if(e == 'No Internet Connection'){
        _getAllCategories(refresh: false);
      }
      else {
        Functions.showError(context, e);
      }
    });
  }

  /// A function to build the list of all the popular categories
  Widget _buildPopularCategories() {
    List<Widget> categoriesList = [];
    if(_allCategories.length > 0 && _allCategories.isNotEmpty){
      for (int i = 0; i < _allCategories.length; i++){
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
              padding: EdgeInsets.fromLTRB(14, 17, 31, 17),
              margin: EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(color: Color(0xFFEBF1F4), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: _allCategories[i].category.smallerImage,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Container(),
                  ),
                  SizedBox(width: 16),
                  Text(
                    _allCategories[i].category.singularName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
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
    else if(_allCategoriesLength == 0){
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

  /// A List to hold the all the hired candidates
  List<HiredCandidates> _hiredCandidates = [];

  /// An Integer variable to hold the length of [_hiredCandidates]
  int hiredCandidatesLength;

  /// Function to fetch all the hired candidates from the database to
  /// [_hiredCandidates]
  void _allHiredCandidates() async {
    Future<List<HiredCandidates>> list = futureValue.getAllHiredCandidatesFromDB();
    await list.then((value) {
      _hiredCandidates.clear();
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          hiredCandidatesLength = 0;
          _hiredCandidates = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _hiredCandidates.addAll(value);
          hiredCandidatesLength = value.length;
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
    if(_hiredCandidates.length > 0 && _hiredCandidates.isNotEmpty){
      for (int i = 0; i < _hiredCandidates.length; i++){
        if(_hiredCandidates[i].status.toLowerCase() == 'ongoing'){
          ongoingContainer.add(
            InkWell(
              onTap: (){
                _buildProfileModalSheet(context, _hiredCandidates[i].getCandidate, _hiredCandidates[i].category, _hiredCandidates[i].id);
              },
              child: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.fromLTRB(13.6, 3, 17, 17),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F7F9),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _hiredCandidates[i].getCandidate.profileImage,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(),
                          ),
                        ),
                        SizedBox(width: 12.4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 9),
                            Text(
                              '${_hiredCandidates[i].getCandidate.firstName} ${_hiredCandidates[i].getCandidate.lastName}' ,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF042538),
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "Available ${_hiredCandidates[i].getCandidate.availability.title == 'Custom' ? 'Weekdays' : 'Full Time'}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 12,
                                color: Color(0xFF9BA8B1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      _categoriesIdName.isNotEmpty
                          ? _categoriesIdName.containsKey(_hiredCandidates[i].category)
                            ? _categoriesIdName[_hiredCandidates[i].category] ?? ''
                            : ''
                          : '',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFFF7941D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
      return ongoingContainer.length > 0
          ? Column(children: ongoingContainer)
          : _buildEmpty('You have no Hired candidate\nat the moment');
    }
    else if(hiredCandidatesLength == 0){
      return _buildEmpty('You have no Hired candidate\nat the moment');
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
              SizedBox(height: 40),
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
              SizedBox(height: 30),
            ]
        )
    );
  }

  /// An Integer variable to hold the length of [_purchases]
  int _purchasesLength;

  /// Function to fetch all the pending purchases from the database to
  /// [_purchases]
  void _allPendingPurchases() async {
    Future<List<Purchases>> list = futureValue.getAllPendingPurchases();
    await list.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _purchasesLength = 0;
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          int val = 0;
          for(int i = 0; i < value.length; i++){
            if(value[i].candidatePlan.any((element) => !element.interviewed)) {
              val += 1;
            }
          }
          _purchasesLength = val;
          _pendingItems = val > 0 ? true : false;
          print(_purchasesLength);
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A variable to hold the AdBanner object
  AdBanner _banner;

  /// A boolean variable to hold if the banner is loaded or not
  bool _bannerLoaded = false;

  /// Function to fetch the ad banner from the database to [_banner]
  void _getAdBanner() async {
    Future<AdBanner> list = futureValue.getAdBanner();
    await list.then((value) {
      print(value.toJson());
      if(!mounted)return;
      setState(() {
        _banner = value;
        _bannerLoaded = true;
      });
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
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
            _pendingItems = true;
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
    _getAllCategories(refresh: true);
    _allPendingPurchases();
    _allHiredCandidates();
    _getAdBanner();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF050729),
        leading: IconButton(
          icon: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.menu,
                  size: 20,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              _pendingItems
                  ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.only(bottom: 13, right: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF7941D)
                  ),
                ),
              )
                  : Container()
            ],
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
            color: Color(0xFFFFFFFF),
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
                                Functions.profileName('$_firstName $_surName'),
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
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 20),
                    height: SizeConfig.screenHeight * 0.6,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          children:[
                            DrawerContainer(
                              title: "Home",
                              imageName: "home",
                              onTap: (){
                                Navigator.pop(context);
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
                                  _allPendingPurchases();
                                  _allHiredCandidates();
                                });
                              },
                            ),
                            DrawerContainer(
                              title: "Interview Schedule",
                              imageName: "scheduled_interview",
                              number: _purchasesLength,
                              onTap: (){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return ScheduledInterview();
                                    }
                                  )
                                ).then((value) {
                                  _getList();
                                  _allPendingPurchases();
                                  _allHiredCandidates();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      TextButton(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF3F6F8),
      body: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 250,
            alignment: Alignment.topCenter,
            color: Color(0xFF050729)
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 23, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _purchasesLength != null
                    ? _purchasesLength > 0
                      ? InkWell(
                  onTap: (){
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_){
                          return ScheduledInterview();
                        }
                        )
                    ).then((value) {
                      _allHiredCandidates();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 12, 22, 13),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.2),
                      border: Border.all(color: Color(0xFFF3903F), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pending Interviews",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFF3903F),
                                ),
                              ),
                              Text(
                                "These are your preferred candidates.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 12,
                                  color: Color(0xFFF3F6F8),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFFFFFFFF),
                          ),
                        ]
                    ),
                  ),
                )
                      : Container()
                    : Container(),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 22),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 19, 20, 21),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(color: Color(0xFFEBF1F4), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hired Candidates",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF042538),
                                ),
                              ),
                              SizedBox(height: 23),
                              _buildOngoing(),
                              SizedBox(height: 23),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (_){
                                        return HireCandidate();
                                      }
                                      )
                                  ).then((value) {
                                    _allHiredCandidates();
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(59, 7, 58, 7),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF4F7F9).withOpacity(0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Our Categories",
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
                                  _allPendingPurchases();
                                });
                              },
                              child: Text(
                                "See All",
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
                        SizedBox(height: 40),
                        _bannerLoaded
                            ? Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.fromLTRB(28, 34, 54, 34),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: _banner.image != null
                                    ? NetworkImage(_banner.image)
                                    : AssetImage('assets/icons/ads.png'),
                                fit: BoxFit.cover,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _banner.title ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                  fontSize: 21,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                _banner.description ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        )
                            : Container(),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildProfileModalSheet(BuildContext context, Candidate candidate, String categoryId, String hireId){
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
                                      candidate.availability.title ?? '',
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
                                      "${candidate.experience} ${candidate.experience > 1 ? 'Years' : 'Year'}",
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
                        Button(
                          onTap: (){
                            Navigator.pop(context);
                            _buildReviewSheet(context, candidate, categoryId, hireId);
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                            child: Text(
                              'Send Review',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
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
                                  decoration: kFieldDecoration.copyWith(
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
}
