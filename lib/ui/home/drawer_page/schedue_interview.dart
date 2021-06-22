import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import '../saved_candidate.dart';
import 'account_tab/edit_profile.dart';
import 'account_tab/password_and_security.dart';
import 'hired_candidate_tab/ongoing.dart';
import 'hired_candidate_tab/previous.dart';

class ScheduledCandidates extends StatefulWidget {
  @override
  _ScheduledCandidatesState createState() => _ScheduledCandidatesState();
}

class _ScheduledCandidatesState extends State<ScheduledCandidates> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        child: SafeArea(
          child: Drawer(
            elevation: 20,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:55 ,),
                    Image.asset("assets/icons/profile.png",width: 64, height: 64, fit:BoxFit.contain,),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left:75,),
                  child: Column(
                      children:[
                        SizedBox(height:52),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return EditProfile();
                                })
                            );
                          },

                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/pen_icon.png",width: 16.67, height:16.67, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Edit Profile",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF00A69D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return PasswordAndSecurity();
                                })
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/security_icon.png",width: 15, height:18.33, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Password & Security",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF5D6970),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return SavedCandidate();
                                })
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset("assets/icons/saved_candidate_icon.png",width: 19.09, height:16.86, fit:BoxFit.contain,),
                                SizedBox(width: 21.67,),
                                Text(
                                  "Saved Candidates",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF5D6970),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFCFDFE),
      body: Container(
        width: SizeConfig.screenWidth,
        padding:EdgeInsets.only(left:24,right: 24),
        child: Column(
          children: [
            SizedBox(height:20),
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
                SizedBox(width:90,),
                Text(
                  "Scheduled Candidates",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            SizedBox(height:25),
            TabBar(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                indicatorColor: Color(0xFF00A69D),
                isScrollable: false,
                labelColor: Color(0xFF00A69D),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                ),
                unselectedLabelColor: Color(0xFF3B4A54),
                tabs:[
                  Tab(
                    text: 'Scheduled\n',
                  ),
                  Tab(
                    text: 'Finished\n',
                  ),
                ]
            ),
            Expanded(
              child: Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  //color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children:[
                    Ongoing(),
                    Previous()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
