import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/location.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

import '../packages.dart';

class MyListCandidate extends StatefulWidget {
  static const String id = 'my_list';
  @override
  _MyListCandidateState createState() => _MyListCandidateState();
}

class _MyListCandidateState extends State<MyListCandidate> {

  /// A list of string variables holding a list of all countries
  List<String> _category = [
    "Butler","Chef","Carpenter","Chaffer","HouseKeeper","Home Tutor","Dog Walker","Hair Stylist","Barber","Caregiver"
  ];

  /// A string variable holding the selected country value
  String _selectedCategory;

  bool isPressed = true;

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
              Container(
                padding: EdgeInsets.only(left: 10),
                child: IconButton(
                    iconSize: 1,
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 19,
                      color: Color(0xFF000000),
                    ),
                    onPressed:(){Navigator.pop(context);}
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: [
//                        Text(
//                          'Chef',
//                          textAlign: TextAlign.start,
//                          style: TextStyle(
//                            fontWeight: FontWeight.w600,
//                            fontFamily: 'Gelion',
//                            fontSize: 19,
//                            color: Color(0xFF000000),
//                          ),
//                        ),
//                        SizedBox(width: 5,),
//                        Image.asset("assets/icons/chef-hat 1.png",height:22,width: 22,fit: BoxFit.contain,)
//                      ],
//                    ),

                  Text(
                          'List',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                            fontSize: 19,
                            color: Color(0xFF000000),
                          ),
                        ),
                    SizedBox(height: 8,),
                    Text(
                      'Aliqua id fugiat nostrud irure ex duis ea quis\nid quis ad et. ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    SizedBox(height: 24,),
                    Container(
                      color: Color(0xFF717F88).withOpacity(0.1),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                        ),
                        value: _selectedCategory,
                        onChanged: (String value){
                          if(!mounted)return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value){
                          if (_selectedCategory == null || _selectedCategory.isEmpty){
                            return 'Pick your option';
                          }
                          return null;
                        },
                        decoration: kFieldDecoration.copyWith(
                          hintText: 'Please select category',
                          hintStyle: TextStyle(
                            color: Color(0xFF717F88),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                          ),
                        ),
                        selectedItemBuilder: (BuildContext context){
                          return _category.map((value){
                            return Text(
                              value,
                              style: TextStyle(
                                color: Color(0xFF1C2D55),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gelion',
                              ),
                            );
                          }).toList();
                        },
                        items: _category.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gelion',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 12,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 24),
                  child: SingleChildScrollView(
                    physics:BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: (){
                              setState(() {
                                isPressed =!isPressed;
                              });
                            },
                            child: _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5)
                        ),
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
