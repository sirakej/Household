import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:householdexecutives_mobile/home/edit_profile.dart';
import 'package:householdexecutives_mobile/home/password_and_security.dart';
import 'package:householdexecutives_mobile/home/saved_candidate.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();
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
      backgroundColor: Color(0xFFF3F6F8),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24,right: 24),
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
                          _buildModalSheet(context);
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
                            "Welcome, Precious",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            "Maryland, Lagos",
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
                      child: Image.asset("assets/icons/notification_baseline.png",height: 24,width:24,fit: BoxFit.contain,)
                  )
                ],
              ),
              SizedBox(height:10,),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height:22),
                        _buildSearch(),
                        SizedBox(height: 20,),
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
                                  ),
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
                                          "Capenter",
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
                                  ),
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
                                  ),
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
                                  ),
                                  SizedBox(width: 10,),
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
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
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
                        SizedBox(height: 18,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildRecommendedContainer("assets/icons/caterer.png","Chef", "Funke", 3.5),
                                _buildRecommendedContainer("assets/icons/dog_walker.png","Dog Walker", "Michelle", 3.5),
                              ],
                            ),
                            SizedBox(height: 18,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildRecommendedContainer("assets/icons/home_tutor.png","Home Tutor", "Taiwo", 3.5),
                                _buildRecommendedContainer("assets/icons/carpenter_cat.png","Carpenter", "Dauda", 3.5),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Center(
                          child: TextButton(
                              onPressed:(){},
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
    return Container(
     width: 160,
      height: 159,
      decoration: BoxDecoration(
        //color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Image.asset(imagePath , fit:BoxFit.contain,width: 160,height: 130,),
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
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
                ],
              ) ,
            ),
          )
        ],
      ),
    );
  }
  _buildModalSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 100,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setState /*You can rename this!*/){
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 24),
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 26,
                      height: 26,
                      child: FloatingActionButton(
                          elevation: 30,
                          backgroundColor: Color(0xFF00A69D).withOpacity(0.25),
                          shape:CircleBorder(),
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
                SizedBox(height:8),
                Container(
                  //height: SizeConfig.screenHeight,
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: TextButton(
                          onPressed:(){
                            Navigator.pop(context);
                            _scaffoldKey.currentState.openDrawer();
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
                      SizedBox(height:20  ,),
                      Center(
                        child: TextButton(
                          onPressed:(){},
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
              ],
            );
          });
        }
    );
  }

}
