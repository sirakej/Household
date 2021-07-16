import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'account-tab/edit-profile.dart';
import 'account-tab/security.dart';
import 'hired-candidate.dart';
import 'schedule-interview.dart';
import 'transaction-details.dart';
import 'purchases/saved-purchases.dart';

class Account extends StatefulWidget {

  static const String id = 'account_settings';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {

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

  @override
  void initState(){
    _getCurrentUser();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            "My Account",
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
              SizedBox(height: 25),
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
                  Tab(text: 'My Profile'),
                  Tab(text: 'Security Settings'),
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
                  children:[
                    EditProfile(),
                    PasswordAndSecurity()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
