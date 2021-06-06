import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class GetSavedList extends StatefulWidget {
  static const String id = 'save_List';
  @override
  _GetSavedListState createState() => _GetSavedListState();
}

class _GetSavedListState extends State<GetSavedList> {
  int count = 1;
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'My List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 19,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              SizedBox(height:29),
              Container(
                width: SizeConfig.screenWidth,
                height: 0.5,
                color: Color(0xFFC4CDD5),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Color(0xFFC4CDD5), width: 0.5, style: BorderStyle.solid)
                    )
                ),
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          isClick = !isClick;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children: [
                                  Text(
                                    "Hire a Butler",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  count > 0
                                      ? Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFE93E3A)
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$count',
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
                                      : Container(),
                                ]
                            ),
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
                              crossFadeState: isClick == true
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 1000),
                              firstCurve: Curves.easeOutCirc,
                              secondCurve: Curves.easeOutCirc,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    AnimatedCrossFade(
                      firstChild: Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap:(){
                                _buildProfileModalSheet(context);
                      },
                                child: _buildCandidateContainer("Seun", "Female", "2", "Weekdays", "Lagos"
                                ))
                          ]
                        ),
                      ),
                      secondChild: Container(),
                      crossFadeState:  isClick == true
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCandidateContainer(String firstName,String gender, String experience, String availability, String residential){
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(left:8, top: 19, bottom: 22, right: 8),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: /*true ? Color(0xFFFFFFFF) :*/ Color(0xFFF7941D).withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            width: 1,
            color: /*true ? Color(0xFFEBF1F4) :*/ Color(0xFFF7941D),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Image.asset(
                    'assets/icons/butler.png',
                    height: 57,
                    width: 72,
                    fit: BoxFit.contain
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$firstName ($gender)",
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
                    '$experience Years Eperience',
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
                    "$availability . $residential",
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "3.5",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 11,
                        color: Color(0xFF717F88),
                      ),
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
              /*IconButton(
                  icon: true
                      ? Icon(
                    Icons.check_box_outline_blank_outlined,
                    size: 25,
                    color:  Color(0xFFF7941D),
                  )
                      : Icon(
                    Icons.check_box_outlined,
                    size: 25,
                    color:  Color(0xFFF7941D),
                  ),
                  onPressed: (){
                    setState(() {
                      //isPressed =! isPressed;
                    });
                  }),*/
            ],
          )
        ],
      ),
    );
  }

  _buildProfileModalSheet(BuildContext context){
    bool viewProfile = false;
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
                                "Seun",
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
                              height: viewProfile ? SizeConfig.screenHeight - 400 : 220,
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
                                                    "Tribe",
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
                                                    "20",
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
                                                    "3 Years +",
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
//                                                  "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
                                                  "working",
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
                                          Container(
                                            width:100,
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
                                          SizedBox(height: 5,),
                                          TextButton(
                                            onPressed: () {  },
                                            child:  Text(
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton(
                                  minWidth: SizeConfig.screenWidth - 150,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 19, 0, 18),
                                  onPressed:(){

                                  },
                                  color: Color(0xFF00A69D),
                                  child: Text(
                                    "Add Candidate to List",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(color: Color(0xFF00A69D),width: 1.4)
                                  ),
                                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                                  onPressed:(){},
                                  color: Color(0xFF00A69D).withOpacity(0.2),
                                  child: Image.asset(
                                      'assets/icons/heart.png',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ],
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
}
