
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class SelectedCandidateList extends StatefulWidget {
  static const String id = 'selected_candidate';
  @override
  _SelectedCandidateListState createState() => _SelectedCandidateListState();
}

class _SelectedCandidateListState extends State<SelectedCandidateList> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left:24,right:24),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 19,
                    color: Color(0xFF000000),
                  ),
                  onPressed:(){Navigator.pop(context);}
              ),
              SizedBox(height: 44,),
              Text(
                'Find a candidate!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gelion',
                  fontSize: 19,
                  color: Color(0xFFF7941D),
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
              InkWell(
                onTap: (){},
                child: Container(
                  width: SizeConfig.screenWidth/3,
                  padding: EdgeInsets.only(left:11,top:18 ,bottom: 18),
                  decoration: BoxDecoration(
                      color: Color(0xFF00A69D).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 2,
                        color: Color(0xFF00A69D)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/Filter.png",height:20,width:20,fit:BoxFit.contain),
                      SizedBox(width:10),
                      Text(
                        "Filter Results",
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
              SizedBox(height: 8,),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),
_buildCandidateContainer("Aderonke","female","2 Years Experience","Available Weekdays","Lagos" ,"assets/icons/butler.png",3.5),
                        SizedBox(height: 6,),

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

  Widget _buildCandidateContainer(String candidateName ,String candidateGender ,String candidateExperienceYears,String candidateAvailability ,String candidateCity, String imagePath , double ratings){
    return InkWell(
      onTap: null,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(left:8 ,top:19,bottom: 22 ),
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(
                width: 1,
                color: Color(0xFFEBF1F4)
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(imagePath,height: 57,width: 72,fit: BoxFit.contain,),
            ),
            SizedBox(width:12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                Container(width: 90,),
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
                    Icon(
                      Icons.ac_unit_sharp,
                      size: 18,
                      color: Color(0xFFF7941D),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
