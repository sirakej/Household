import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class SavedCandidate extends StatefulWidget {
  static const String id = 'saved_candidate';
  @override
  _SavedCandidateState createState() => _SavedCandidateState();
}

class _SavedCandidateState extends State<SavedCandidate> {
  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();
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
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular( 10.295)) ,
        boxShadow:[

        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
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
              Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Image.asset("",width:49,height:49,fit: BoxFit.contain,))
            ],
          ),
          Column(
            children: [

          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
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
              Column(
                children: [
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
            ],
          ),
          SizedBox(height:23.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
          ],
          )
        ],
      ),
    );
  }

}
