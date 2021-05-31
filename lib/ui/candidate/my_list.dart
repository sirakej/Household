import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

import '../packages.dart';

class MyListCandidate extends StatefulWidget {
  static const String id = 'my_list';
  @override
  _MyListCandidateState createState() => _MyListCandidateState();
}

class _MyListCandidateState extends State<MyListCandidate> {
  bool isPressed = false;
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left:0,right:24),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 20,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(width:16,),
                      Center(
                        child: Text(
                          "My List (4)",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                            fontSize: 19,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Center(
                    child: Text(
                      'You’re only allowed to select a maximmum of 3\ncandidates per category',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 24),
                  child: SingleChildScrollView(
                    physics:BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        _buildListContainer("Butler"),
                        SizedBox(height: 15,),
                        _buildListContainer("Chef"),
                        SizedBox(height: 15,),
                        _buildListContainer("Chaffeur"),
                        SizedBox(height: 15,),
                        _buildListContainer("Doorman"),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 24),
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  minWidth: SizeConfig.screenWidth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.only(top:18 ,bottom: 18),
                  onPressed:(){
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_){
                          return Packages();
                        })
                    );
                  },
                  color: Color(0xFF00A69D),
                  child: Text(
                    "Proceed To Payment",
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
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListContainer(String categoryName){
    return InkWell(
      onTap: (){
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Hire a $categoryName",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE93E3A)
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Gelion',
                            fontSize: 8,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    )
                ],),
                AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.keyboard_arrow_down,
                    size: 19,
                    color: Color(0xFF000000),
                  ),
                  secondChild: Icon(
                    Icons.keyboard_arrow_up,
                    size: 19,
                    color: Color(0xFF000000),
                  ),
                  crossFadeState: isPressed == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 1000),
                  firstCurve: Curves.easeOutCirc,
                  secondCurve: Curves.easeOutCirc,
                )

              ],
            ),
            AnimatedCrossFade(
                firstChild: Container(
                  child: Column(
                    children: [
                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                      Center(
                        child:IconButton(
                          iconSize: 22,
                          onPressed: () {  },
                          icon: Icon(
                            Icons.add_circle,
                            color: Color(0xFF00A69D),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                secondChild: Container(),
                crossFadeState: isPressed == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
                duration: Duration(milliseconds: 500),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildCandidateContainer(String candidateName ,String candidateGender ,String candidateExperienceYears,String candidateAvailability ,String candidateCity, String imagePath , double ratings){
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(left:8 ,top:19,bottom: 22,right: 8 ),
      decoration: BoxDecoration(
          color: isPressed?Color(0xFFFFFFFF):Color(0xFFF7941D).withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(
              width: 1,
              color: isPressed?Color(0xFFEBF1F4):Color(0xFFF7941D),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Image.asset(imagePath,height: 57,width: 72,fit: BoxFit.contain,),
          ),
          SizedBox(width:12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$candidateName($candidateGender)",
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF042538),
                ),
              ),
              Text(
                candidateExperienceYears,
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 12,
                  color: Color(0xFFF7941D),
                ),
              ),
              Text(
                "$candidateAvailability . $candidateCity",
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 12,
                  color: Color(0xFF717F88),
                ),
              ),
            ],
          ),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "$ratings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 11,
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
              IconButton(
                  icon: isPressed?Icon(
                    Icons.check_box_outline_blank_outlined,
                    size: 25,
                    color:  Color(0xFFF7941D),
                  ):Icon(
                    Icons.check_box_outlined,
                    size: 25,
                    color:  Color(0xFFF7941D),
                  ),
                  onPressed: (){
                    setState(() {
                      isPressed =! isPressed;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }

}
