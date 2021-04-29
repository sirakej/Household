import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/home/home_screen.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class PickedList extends StatefulWidget {
  static const String id = 'picked_list';
  @override
  _PickedListState createState() => _PickedListState();
}

class _PickedListState extends State<PickedList> {

  /// A list of string variables holding a list of all countries
  List<String> _category = [
    "Butlers","Caregivers","Carpenters","Chauffeurs","Chefs","Doormen","Electricians","Gardeners","GateKeepers","Housekeepers","Nannies","Plumbers"
  ];

  /// A string variable holding the selected country value
  String _selectedCategory;


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
                      'You’re only allowed to select a maximmum of 3\ncandidates per category',
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
                              _buildCandidateReview(context);
                            },
                            child: _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                  padding: EdgeInsets.fromLTRB(24, 46, 24, 0),
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
                        child: Text(
                          "Request Sent",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(height:16),
                      Center(
                        child: Text(
                          "This candidate has been added to your\ncurrent preference list",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(height: 28,),
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
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
              ],
            );
          });
        }
    );
  }
  _buildCandidateReview(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 0, 24, 38),
                        margin: EdgeInsets.only(top: 34),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 89),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Aderonke",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF042538),
                                ),
                              ),
                            ),
                            SizedBox(height: 27),
                            Container(
                              height:SizeConfig.screenHeight - 400,
                              child: Scrollbar(
                                thickness: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
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
                                                    "HE55778",
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
                                                    "Tribe:",
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
                                                    "Yoruba",
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
                                                    "Live Out",
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
                                                    "28",
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
                                                    "Residence:",
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
                                                    "Lagos",
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
                                                        "3.5 ",
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
                                                    "Female",
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
                                                    "2 Years +",
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
                                                  "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
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
                                              SizedBox(height:8),
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Color(0xFF717F88),
                                                        ),
                                                        SizedBox(width:8),
                                                        Text(
                                                          "8 months at Radisson BLU Anchorage Hote",
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
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Color(0xFF717F88),
                                                        ),
                                                        SizedBox(width:8),
                                                        Text(
                                                          " 4 months at Best Western Hotel Ikeja",
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
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          size:12,
                                                          color: Color(0xFF717F88),
                                                        ),
                                                        SizedBox(width:8),
                                                        Text(
                                                          "12 months at Southern SUN Ikoyi.",
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
                                                  ]
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Reports Available:",
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
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Identity Verification",
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Criminal Record",
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Medical Profile and History",
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Residential Address Verification",
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Guarantors Profile Verification",
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size:12,
                                                        color: Color(0xFF717F88),
                                                      ),
                                                      SizedBox(width:8),
                                                      Text(
                                                        "Work History Verification ",
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
                                          SizedBox(height: 15),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            FlatButton(
                              minWidth: SizeConfig.screenWidth,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.fromLTRB(0, 19, 0, 18),
                              onPressed:(){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return HomeScreen();
                                    })
                                );
                                _buildModalSheet(context);
                              },
                              color: Color(0xFF00A69D),
                              child: Text(
                                "Request Candidate",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                onPressed:(){},
                                child: Text(
                                  "Schedule An Interview",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFF717F88),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 120,
                              height: 120,
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
  }
  Widget _buildCandidateContainer(String candidateName ,String candidateGender ,String candidateExperienceYears,String candidateAvailability ,String candidateCity, String imagePath , double ratings){
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(left:8 ,top:19,bottom: 22,right: 8 ),
      decoration: BoxDecoration(
          color:Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            width: 1,
            color:Color(0xFFEBF1F4),
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
          )
        ],
      ),
    );
  }

}
