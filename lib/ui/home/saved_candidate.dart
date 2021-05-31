import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class SavedCandidate extends StatefulWidget {
  static const String id = 'saved_candidate';
  @override
  _SavedCandidateState createState() => _SavedCandidateState();
}

class _SavedCandidateState extends State<SavedCandidate> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                      Text(
                        "Saved Candidates",
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
                        _savedCandidateContainer()
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

  Widget _savedCandidateContainer(){
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(left: 21,top: 23,right: 20,bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular( 10.295)) ,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Aderonke",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF042538),
                    ),
                  ),
                  SizedBox(height:8.51),
                  Text(
                    "2 Years Experience",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFF7B7977),
                    ),
                  ),
                ],
              ),
              Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Image.asset("",width:49,height:49,fit: BoxFit.contain,))
            ],
          ),
          SizedBox(height:29),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "AVAILABILITY",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFF717F88),
                    ),
                  ),
                  Text(
                    "Weekdays Only",
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
              Column(
                children: [
                  Text(
                    "LOCATION",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFF717F88),
                    ),
                  ),
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
            ],
          ),
          SizedBox(height:24.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                minWidth: 106.76,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                ),
                padding: EdgeInsets.only(top:18 ,bottom: 18),
                onPressed:(){},
                color: Color(0xFF00A69D),
                child:Text(
                  "Hire Now",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(width:5),
              TextButton(
                onPressed:(){},
                child: Text(
                  "Remove from list",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFFE93E3A),
                  ),
                ),
              ),
          ],
          )
        ],
      ),
    );
  }

}
