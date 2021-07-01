import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/ui/candidate/find-category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'drawer-page/account.dart';
import 'drawer-page/hired-candidate.dart';
import 'drawer-page/purchases/saved-purchases.dart';
import 'drawer-page/transaction-details.dart';
import 'drawer-page/schedule-interview.dart';

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

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
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
                              Constants.profileName('$_surName $_firstName'),
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
                                    }
                                    )
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
                              title: "My List",
                              imageName: "my_list",
                              onTap: (){
                                Navigator.pop(context);

                                /*Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return null;
                                    }
                                    )
                                );*/
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
                                    })
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
      ),
      backgroundColor: Color(0xFFF3F6F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 22),
                        _buildSearch(),
                        SizedBox(height: 20),
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
                              onPressed: (){},
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
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_,__)=>  Row(
                                children: [
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/waiter.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "Butler",
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
                                  ),//butler
                                  SizedBox(width: 10,),
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/baby-boy 1.png",width: 24,height: 24,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "Caregiver",
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
                                  ),//caregiver
                                  SizedBox(width: 10,),
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/hammer 1.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "Carpenter",
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
                                  ),//car
                                  SizedBox(width: 10,),
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/taxi-driver 1.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "Chauffeur",
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
                                  ),//chauffeur
                                  SizedBox(width: 10,),
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/chef-hat 1.png",width:20 ,height: 20,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "Chef",
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
                                  ),//chef
                                  SizedBox(width: 10,),
                                  Container(
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/broom.png",width: 16,height: 22,fit: BoxFit.contain,),
                                        SizedBox(width: 6,),
                                        Text(
                                          "House Keeper",
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
                                  ),//housekeeper
                                ],
                              )
                          ),
                        ),
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
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildRecommendedContainer("assets/icons/caterer.png","Chef", "Funke", 3.5),
                                SizedBox(width: 50,),
                                _buildRecommendedContainer("assets/icons/home_plumber.png","Plumber", "Michelle", 3.5),
                              ],
                            ),
                            SizedBox(height: 18,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildRecommendedContainer("assets/icons/home_electrician.png","Electrician", "Taiwo", 3.5),
                                SizedBox(width: 50,),
                                _buildRecommendedContainer("assets/icons/home_carpenter.png","Carpenter", "Dauda", 3.5),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: TextButton(
                              onPressed:(){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      //return SelectedList();
                                      return FindACategory();
                                    })
                                );
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
                        SizedBox(height:7),
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Image.asset("assets/icons/ads.png",fit:BoxFit.contain,width:327 ,height:96)
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
                                    SizedBox(height: 6,),
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
                        )
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

  Widget _buildRecommendedContainer(String imagePath,String category,String candidateName, double ratings ){
    return FittedBox(
      child: Container(
       width: SizeConfig.screenWidth/2.8,
        height: 159,
        decoration: BoxDecoration(
          //color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Stack(
          children: [
            Image.asset(imagePath , fit:BoxFit.contain,width:SizeConfig.screenWidth,height: 160,),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth/2.8,
                padding: EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 11),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 13,
                            color: Color(0xFF042538),
                          ),
                        ),
                        Text(
                          candidateName,
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
                      children: [
                        Text(
                          "$ratings",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 12,
                            color: Color(0xFF717F88),
                          ),
                        ),
                        Image.asset("assets/icons/star.png",width:10 ,height:8.81,fit:BoxFit.contain ,)
                      ],
                    ),
                  ],
                ) ,
              ),
            )
          ],
        ),
      ),
    );
  }

  /*_buildModalSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setState *//*
          You can rename this!*//*){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Container(
                        //height: SizeConfig.screenHeight,
                        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        margin: EdgeInsets.only(top: 34),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisSize:  MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 64),
                            Center(
                              child: Text(
                                "Akande Seun",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF042538),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: TextButton(
                                onPressed:(){
                                  },
                                child: Text(
                                  "Update profile information",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF00A69D),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            FlatButton(
                              minWidth: SizeConfig.screenWidth,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2,
                                      color: Color(0xFF00A69D)
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.only(top:18 ,bottom: 18),
                              onPressed:(){},
                              color: Color(0xFF00A69D).withOpacity(0.4),
                              child: Text(
                                "Hire from a different category",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF00A69D),
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            FlatButton(
                              minWidth: SizeConfig.screenWidth,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: Color(0xFFC4C4C4).withOpacity(0.48),
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.only(top:18 ,bottom: 18),
                              onPressed:(){},
                              child: Text(
                                "View List",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF00A69D),
                                ),
                              ),
                            ),
                            SizedBox(height:15,),
                            Center(
                              child: TextButton(
                                onPressed:(){
                                  _logout();
                                },
                                child: Text(
                                  "Sign Out",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFFE36D45),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 90,
                              height: 90,
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
  }*/

}
