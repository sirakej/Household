import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'account-tab/edit-profile.dart';
import 'account-tab/security.dart';

class Account extends StatefulWidget {

  static const String id = 'account_settings';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState(){
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
