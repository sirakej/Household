import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/packages.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class CandidateContainer extends StatefulWidget {

  final Category category;
  final Candidate candidate;
  final Function onPressed;

  const CandidateContainer({
    Key key,
    @required this.category,
    @required this.candidate,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _CandidateContainerState createState() => _CandidateContainerState();
}

class _CandidateContainerState extends State<CandidateContainer> {

  bool isPressed = false;
  bool isShow = false;


//  Widget _buildList() {
//    if(_candidates.length > 0 && _candidates.isNotEmpty){
//      _candidatesList.clear();
//      for (int i = 0; i < _candidates.length; i++){
//        if(!_selectedCandidate[_candidates[i]]) {
//          _candidatesList.add(
//            Container(
//              margin: EdgeInsets.only(bottom: 8),
//              child: CandidateContainer(
//                candidate: _candidates[i],
//                category: widget.category,
//              ),
//            ),
//          );
//        }
//      }
//
//      return Column(
//        children: _candidatesList,
//      );
//    }
//    else if(_candidatesLength == 0){
//      return Container();
//    }
//    return Center(child: CupertinoActivityIndicator(radius: 15));
//  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.fromLTRB(8, 17, 12, 22),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color:Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border:Border.all(width: 1, color: Color(0xFFEBF1F4)),
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
                    "assets/icons/butler.png",
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
                      "${widget.candidate.firstName} (${widget.candidate.gender})",
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
                      "${widget.candidate.experience} Years Experience",
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
                      "${widget.candidate.availablity} . ${widget.candidate.resedential}",
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
            )
          ],
        ),
      ),
    );
  }

//  _buildProfileModalSheet(BuildContext context){
//    bool viewProfile = false;
//    showModalBottomSheet<void>(
//        backgroundColor: Colors.transparent,
//        isScrollControlled: true,
//        barrierColor: Color(0xFF07072B).withOpacity(0.81),
//        isDismissible: false,
//        context: context,
//        builder: (BuildContext context){
//          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
//            return Column(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//                Container(
//                  width: SizeConfig.screenWidth,
//                  child: Stack(
//                    children: [
//                      Container(
//                        padding: EdgeInsets.fromLTRB(24, 0, 24, 38),
//                        margin: EdgeInsets.only(top: 34),
//                        width: SizeConfig.screenWidth,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.only(
//                              topRight: Radius.circular(30),
//                              topLeft: Radius.circular(30)
//                          ),
//                        ),
//                        child: Column(
//                          mainAxisSize: MainAxisSize.min,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            SizedBox(height: 89),
//                            Align(
//                              alignment: Alignment.topCenter,
//                              child: Text(
//                                "${widget.candidate.firstName}",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontFamily: 'Gelion',
//                                  fontSize: 16,
//                                  color: Color(0xFF042538),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 27),
//                            Container(
//                              height: viewProfile ? SizeConfig.screenHeight - 400 : 220,
//                              child: Scrollbar(
//                                thickness: 3,
//                                child: SingleChildScrollView(
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      SizedBox(height: 10),
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "ID Number:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height: 8),
//                                                  Text(
//                                                    "HE55778",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                              SizedBox(height: 18),
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Tribe",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height: 8),
//                                                  Text(
//                                                    "${widget.candidate.origin}",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                              SizedBox(height: 18),
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Availability:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height: 8),
//                                                  Text(
//                                                    "Live Out",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                            ],
//                                          ),
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Age:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height:8),
//                                                  Text(
//                                                    "${widget.candidate.age}",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                              SizedBox(height: 18),
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Residence:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height:8),
//                                                  Text(
//                                                    "Lagos",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                              SizedBox(height: 18),
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Rating:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height: 8),
//                                                  Row(
//                                                    children: [
//                                                      Text(
//                                                        "3.5 ",
//                                                        textAlign: TextAlign.start,
//                                                        style: TextStyle(
//                                                          fontWeight: FontWeight.w400,
//                                                          fontFamily: 'Gelion',
//                                                          fontSize: 14,
//                                                          color: Color(0xFF717F88),
//                                                        ),
//                                                      ),
//                                                      Image.asset(
//                                                          'assets/icons/star.png',
//                                                          width: 18,
//                                                          height: 15,
//                                                          color: Color(0xFFF7941D),
//                                                          fit: BoxFit.contain
//                                                      )
//                                                    ],
//                                                  ),
//                                                ],
//                                              ),
//                                            ],
//                                          ),
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Gender:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height:8),
//                                                  Text(
//                                                    "${widget.candidate.gender}",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                              SizedBox(height: 18),
//                                              Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Text(
//                                                    "Experience:",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF042538),
//                                                    ),
//                                                  ),
//                                                  SizedBox(height:8),
//                                                  Text(
//                                                    "${widget.candidate.experience} Years +",
//                                                    textAlign: TextAlign.start,
//                                                    style: TextStyle(
//                                                      fontWeight: FontWeight.w400,
//                                                      fontFamily: 'Gelion',
//                                                      fontSize: 14,
//                                                      color: Color(0xFF717F88),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                      viewProfile
//                                          ? Column(
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//                                          SizedBox(height: 30),
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                "Unique Skill(s):",
//                                                textAlign: TextAlign.start,
//                                                style: TextStyle(
//                                                  fontWeight: FontWeight.w400,
//                                                  fontFamily: 'Gelion',
//                                                  fontSize: 14,
//                                                  color: Color(0xFF042538),
//                                                ),
//                                              ),
//                                              SizedBox(height: 8),
//                                              Container(
//                                                width: SizeConfig.screenWidth - 120,
//                                                child: Text(
////                                                  "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
//                                                    "${widget.candidate.skill}",
//                                                  textAlign: TextAlign.start,
//                                                  style: TextStyle(
//                                                    fontWeight: FontWeight.w400,
//                                                    fontFamily: 'Gelion',
//                                                    fontSize: 14,
//                                                    color: Color(0xFF717F88),
//                                                  ),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                          SizedBox(height: 18),
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                "Work History:",
//                                                textAlign: TextAlign.start,
//                                                style: TextStyle(
//                                                  fontWeight: FontWeight.w400,
//                                                  fontFamily: 'Gelion',
//                                                  fontSize: 14,
//                                                  color: Color(0xFF042538),
//                                                ),
//                                              ),
//                                              SizedBox(height:8),
//                                              Column(
//                                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                                  children: [
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.start,
//                                                      children: [
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Color(0xFF717F88),
//                                                        ),
//                                                        SizedBox(width:8),
//                                                        Text(
//                                                          "8 months at Radisson BLU Anchorage Hote",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.start,
//                                                      children: [
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Color(0xFF717F88),
//                                                        ),
//                                                        SizedBox(width:8),
//                                                        Text(
//                                                          " 4 months at Best Western Hotel Ikeja",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.start,
//                                                      children: [
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Color(0xFF717F88),
//                                                        ),
//                                                        SizedBox(width:8),
//                                                        Text(
//                                                          "12 months at Southern SUN Ikoyi.",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                  ]
//                                              ),
//                                            ],
//                                          ),
//                                          SizedBox(height: 18),
//                                          Container(
//                                            width:100,
//                                            child: Column(
//                                              crossAxisAlignment: CrossAxisAlignment.start,
//                                              children: [
//                                                Text(
//                                                  "Verifications:",
//                                                  textAlign: TextAlign.start,
//                                                  style: TextStyle(
//                                                    fontWeight: FontWeight.w400,
//                                                    fontFamily: 'Gelion',
//                                                    fontSize: 14,
//                                                    color: Color(0xFF042538),
//                                                  ),
//                                                ),
//                                                SizedBox(height: 8),
//                                                Column(
//                                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                                  children: [
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                      children: [
//                                                        Text(
//                                                          "Identity",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Colors.redAccent,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                      children: [
//                                                        Text(
//                                                          "Residence",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Colors.redAccent,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                                      children: [
//                                                        Text(
//                                                          "Guarantors",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Colors.redAccent,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    Row(
//                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                                      children: [
//                                                        Text(
//                                                          "Health Status",
//                                                          textAlign: TextAlign.start,
//                                                          style: TextStyle(
//                                                            fontWeight: FontWeight.w400,
//                                                            fontFamily: 'Gelion',
//                                                            fontSize: 14,
//                                                            color: Color(0xFF717F88),
//                                                          ),
//                                                        ),
//                                                        Icon(
//                                                          Icons.check,
//                                                          size:12,
//                                                          color: Colors.redAccent,
//                                                        ),
//                                                      ],
//                                                    ),
//                                                  ],
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                          SizedBox(height: 5,),
//                                          TextButton(
//                                            onPressed: () {  },
//                                            child:  Text(
//                                              "view official HE Report",
//                                              textAlign: TextAlign.start,
//                                              style: TextStyle(
//                                                fontWeight: FontWeight.w400,
//                                                decoration: TextDecoration.underline,
//                                                fontFamily: 'Gelion',
//                                                fontSize: 14,
//                                                color: Colors.blueAccent,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(height: 15),
//                                        ],
//                                      )
//                                          : Container(),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 15),
//                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: [
//                                FlatButton(
//                                  minWidth: SizeConfig.screenWidth - 150,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(8)
//                                  ),
//                                  padding: EdgeInsets.fromLTRB(0, 19, 0, 18),
//                                  onPressed:(){
//                                    if(!viewProfile){
//                                      setModalState(() {
//                                        viewProfile = true;
//                                      });
//                                    }
//                                    else if(viewProfile == true){
//                                      Navigator.pop(context);
//                                      _buildMyList(context);
//                                    }
//                                  },
//                                  color: Color(0xFF00A69D),
//                                  child: Text(
//                                    !viewProfile
//                                        ? "View Full Profile"
//                                        : "Add Candidate to List",
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w400,
//                                      fontFamily: 'Gelion',
//                                      fontSize: 16,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(width: 14),
//                                FlatButton(
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(6),
//                                      side: BorderSide(color: Color(0xFF00A69D),width: 1.4)
//                                  ),
//                                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
//                                  onPressed:(){},
//                                  color: Color(0xFF00A69D).withOpacity(0.2),
//                                  child: Image.asset(
//                                      'assets/icons/heart.png',
//                                      height: 24,
//                                      width: 24,
//                                      fit: BoxFit.contain
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                      Stack(
//                        alignment: Alignment.topCenter,
//                        children: [
//                          Align(
//                            alignment: Alignment.topCenter,
//                            child: Container(
//                              width: 120,
//                              height: 120,
//                              decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                              ),
//                              child: Image.asset(
//                                "assets/icons/profile.png",
//                                // width: 90,
//                                // height: 90,
//                                fit:BoxFit.cover,
//                              ),
//                            ),
//                          ),
//                          Align(
//                            alignment: Alignment.topRight,
//                            child: Container(
//                                padding: EdgeInsets.only(right: 24),
//                                child: Container(
//                                  width: 26,
//                                  height: 26,
//                                  child: FloatingActionButton(
//                                      elevation: 30,
//                                      backgroundColor: Color(0xFF00A69D).withOpacity(0.25),
//                                      shape: CircleBorder(),
//                                      onPressed: (){
//                                        Navigator.pop(context);
//                                      },
//                                      child: Icon(
//                                        Icons.close,
//                                        color: Color(0xFFFFFFFF),
//                                        size:13,
//                                      )
//                                  ),
//                                )
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            );
//          });
//        }
//    );
//  }
//
//  _buildMyList(BuildContext context){
//    bool isPressed = false;
//    showModalBottomSheet(
//        backgroundColor: Colors.white,
//        elevation: 100,
//        isScrollControlled: true,
//        barrierColor: Color(0xFF07072B).withOpacity(0.81),
//        isDismissible: true,
//        context: context,
//        builder: (BuildContext context){
//          return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState){
//            return Column(
//              children: [
//                Expanded(
//                  child: Container(
//                    padding: EdgeInsets.only(left: 24,right:24),
//                    child: SingleChildScrollView(
//                      physics:BouncingScrollPhysics(),
//                      child: Column(
//                        children: [
//                          SizedBox(height: 50,),
//                          _buildListContainer(widget.category.category.name,setState),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//                Container(
//                  padding: EdgeInsets.only(left: 24,right:24),
//                  alignment: Alignment.bottomCenter,
//                  child: FlatButton(
//                    minWidth: SizeConfig.screenWidth,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(8)
//                    ),
//                    padding: EdgeInsets.only(top:18 ,bottom: 18),
//                    onPressed:(){
//                      Navigator.push(context,
//                          CupertinoPageRoute(builder: (_){
//                            return Packages();
//                          })
//                      );
//                    },
//                    color: Color(0xFF00A69D),
//                    child: Text(
//                      "Proceed To Payment",
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                        fontWeight: FontWeight.w400,
//                        fontFamily: 'Gelion',
//                        fontSize: 16,
//                        color: Color(0xFFFFFFFF),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            );
//          });
//        }
//    );
//  }
//
//  Widget _buildListContainer(String categoryName,dynamic setState){
//    return Container(
//      child: Column(
//        children: [
//          Column(
//            children: [
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    isShow = !isShow;
//                  });
//                },
//                child: AnimatedContainer(
//                  duration: Duration(milliseconds: 250),
//                  child: Column(
//                    children: [
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          Row(
//                            children: [
//                              Text(
//                                "Hire a ${widget.category.category.name}  ",
//                                textAlign: TextAlign.start,
//                                style: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  fontFamily: 'Gelion',
//                                  fontSize: 16,
//                                  color: Color(0xFF000000),
//                                ),
//                              ),
//                              Container(
//                                width: 14,
//                                height: 14,
//                                decoration: BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    color: Color(0xFFE93E3A)
//                                ),
//                                child: Center(
//                                  child: Text(
//                                    "1",
//                                    textAlign: TextAlign.start,
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w500,
//                                      fontFamily: 'Gelion',
//                                      fontSize: 8,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                  ),
//                                ),
//                              )
//                            ],),
//                          AnimatedCrossFade(
//                            firstChild: Icon(
//                              Icons.keyboard_arrow_down,
//                              size: 19,
//                              color: Color(0xFF000000),
//                            ),
//                            secondChild: Icon(
//                              Icons.keyboard_arrow_up,
//                              size: 19,
//                              color: Color(0xFF000000),
//                            ),
//                            crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
//                            duration: Duration(milliseconds: 1000),
//                            firstCurve: Curves.easeOutCirc,
//                            secondCurve: Curves.easeOutCirc,
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(height:22),
//              AnimatedCrossFade(
//                firstChild: Container(
//                  child: Column(
//                    children: [
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      SizedBox(height: 5,),
//                      Center(
//                        child:IconButton(
//                          iconSize: 32,
//                          onPressed: () {  },
//                          icon: Icon(
//                            Icons.add_circle,
//                            color: Color(0xFF00A69D),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                secondChild: Container(),
//                crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
//                duration: Duration(milliseconds: 500),
//              ),
//            ],
//          ),
//          Column(
//            children: [
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    isShow = !isShow;
//                  });
//                },
//                child: AnimatedContainer(
//                  duration: Duration(milliseconds: 250),
//                  child: Column(
//                    children: [
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          Row(
//                            children: [
//                              Text(
//                                "Hire a ${widget.category.category.name}",
//                                textAlign: TextAlign.start,
//                                style: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  fontFamily: 'Gelion',
//                                  fontSize: 16,
//                                  color: Color(0xFF000000),
//                                ),
//                              ),
//                              Container(
//                                width: 14,
//                                height: 14,
//                                decoration: BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    color: Color(0xFFE93E3A)
//                                ),
//                                child: Center(
//                                  child: Text(
//                                    "1",
//                                    textAlign: TextAlign.start,
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w500,
//                                      fontFamily: 'Gelion',
//                                      fontSize: 8,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                  ),
//                                ),
//                              )
//                            ],),
//                          AnimatedCrossFade(
//                            firstChild: Icon(
//                              Icons.keyboard_arrow_down,
//                              size: 19,
//                              color: Color(0xFF000000),
//                            ),
//                            secondChild: Icon(
//                              Icons.keyboard_arrow_up,
//                              size: 19,
//                              color: Color(0xFF000000),
//                            ),
//                            crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
//                            duration: Duration(milliseconds: 1000),
//                            firstCurve: Curves.easeOutCirc,
//                            secondCurve: Curves.easeOutCirc,
//                          )
//
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(height:22),
//              AnimatedCrossFade(
//                firstChild: Container(
//                  child: Column(
//                    children: [
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5,setState),
//                      SizedBox(height: 5,),
//                      Center(
//                        child:IconButton(
//                          iconSize: 32,
//                          onPressed: () {  },
//                          icon: Icon(
//                            Icons.add_circle,
//                            color: Color(0xFF00A69D),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                secondChild: Container(),
//                crossFadeState: isShow == true ?CrossFadeState.showSecond:CrossFadeState.showFirst,
//                duration: Duration(milliseconds: 500),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildCandidateContainer(String candidateName,String candidateGender ,String candidateExperienceYears,String candidateAvailability ,String candidateCity, String imagePath , double ratings,dynamic setState){
//    return Container(
//      width: SizeConfig.screenWidth,
//      padding: EdgeInsets.only(left:8, top: 19, bottom: 22, right: 8),
//      margin: EdgeInsets.only(bottom: 15),
//      decoration: BoxDecoration(
//          color: isPressed?Color(0xFFFFFFFF):Color(0xFFF7941D).withOpacity(0.1),
//          borderRadius: BorderRadius.all(Radius.circular(6)),
//          border: Border.all(
//            width: 1,
//            color: isPressed?Color(0xFFEBF1F4):Color(0xFFF7941D),
//          )
//      ),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          Row(
//            children: [
//              Container(
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.all(Radius.circular(6)),
//                ),
//                child: Image.asset(imagePath,height: 57,width: 72,fit: BoxFit.contain,),
//              ),
//              SizedBox(width: 12),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Text(
//                    "$candidateName ($candidateGender)",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      //letterSpacing: 1,
//                      fontWeight: FontWeight.w500,
//                      fontFamily: 'Gelion',
//                      fontSize: 16,
//                      color: Color(0xFF042538),
//                    ),
//                  ),
//                  Text(
//                    candidateExperienceYears,
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      //letterSpacing: 1,
//                      fontWeight: FontWeight.w500,
//                      fontFamily: 'Gelion',
//                      fontSize: 12,
//                      color: Color(0xFFF7941D),
//                    ),
//                  ),
//                  Text(
//                    "$candidateAvailability . $candidateCity",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      //letterSpacing: 1,
//                      fontWeight: FontWeight.w400,
//                      fontFamily: 'Gelion',
//                      fontSize: 12,
//                      color: Color(0xFF717F88),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//          Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Row(
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.only(top: 2.0),
//                    child: Text(
//                      "$ratings",
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                        //letterSpacing: 1,
//                        fontWeight: FontWeight.w400,
//                        fontFamily: 'Gelion',
//                        fontSize: 11,
//                        color: Color(0xFF717F88),
//                      ),
//                    ),
//                  ),
//                  Image.asset(
//                      'assets/icons/star.png',
//                      width: 18,
//                      height: 15,
//                      color: Color(0xFFF7941D),
//                      fit: BoxFit.contain
//                  )
//                ],
//              ),
//              IconButton(
//                  icon: isPressed
//                      ? Icon(
//                    Icons.check_box_outline_blank_outlined,
//                    size: 25,
//                    color:  Color(0xFFF7941D),
//                  )
//                      : Icon(
//                    Icons.check_box_outlined,
//                    size: 25,
//                    color:  Color(0xFFF7941D),
//                  ),
//                  onPressed: (){
//                    setState(() {
//                      isPressed =! isPressed;
//                    });
//                  }),
//            ],
//          )
//        ],
//      ),
//    );
//  }

}
