import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/candidate/my_list.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class CandidateContainer extends StatelessWidget {

  final String candidateName;
  final String candidateGender;
  final String candidateExperienceYears;
  final String candidateAvailability;
  final String candidateCity;
  final String imagePath;
  final double ratings;

  const CandidateContainer({
    Key key,
    @required this.candidateName,
    @required this.candidateGender,
    @required this.candidateExperienceYears,
    @required this.candidateAvailability,
    @required this.candidateCity,
    @required this.imagePath,
    @required this.ratings
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        _buildProfileModalSheet(context);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.fromLTRB(8, 17, 12, 22),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(width: 1, color: Color(0xFFEBF1F4))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset("assets/icons/$imagePath.png",height: 57,width: 72,fit: BoxFit.contain,),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(height: 64),
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
                                      viewProfile
                                          ? Column(
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
                                          : Container(),
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
                                    if(!viewProfile){
                                      setModalState(() {
                                        viewProfile = true;
                                      });
                                    }else if(viewProfile == true){
                                      Navigator.push(context,
                                          CupertinoPageRoute(builder: (_){
                                            return MyListCandidate();
                                          })
                                      );
                                    }
                                  },
                                  color: Color(0xFF00A69D),
                                  child: Text(
                                    !viewProfile
                                        ? "View Full Profile"
                                        : "Add Candidate to List",
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
  }

}
