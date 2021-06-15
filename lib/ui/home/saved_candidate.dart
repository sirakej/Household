import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/mySavedList.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SavedCandidate extends StatefulWidget {
  static const String id = 'saved_candidate';
  @override
  _SavedCandidateState createState() => _SavedCandidateState();
}

class _SavedCandidateState extends State<SavedCandidate> {

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();
  bool isClick = false;

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<SavedCategory, List<Candidate>> _candidates = {};

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<SavedCategory, bool> _categoriesSelection = {};

  /// A List to hold the all the available categories
  List<MySavedList> _mySavedList = [];

  /// An Integer variable to hold the length of [_mySavedList]
  int _mySavedListLength;

  /// A List to hold the widgets of all the saved list
  List<Widget> _savedListContainer = [];

  /// Function to fetch all the saved list from the database to
  /// [_mySavedList]
  void _allSavedList() async {
    Future<List<MySavedList>> list = futureValue.getAllSavedListFromDB();
    await list.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _mySavedListLength = 0;
          _mySavedList = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _mySavedList.addAll(value.reversed);
          _mySavedListLength = value.length;
          for(int i = 0; i < value.length; i++){
            _categoriesSelection[value[i].category] = false;
            _candidates[value[i].category] = value[i].candidate;
          }
        });
      }
    }).catchError((e){
      print(e);
      Constants.showError(context, e);
    });
  }
  /// A function to build the list of all the saved list
  Widget _buildAllSavedList() {
    if(_mySavedList.length > 0 && _mySavedList.isNotEmpty){
      _savedListContainer.clear();
      for (int i = 0; i < _mySavedList.length; i++){
        print(_mySavedList[i].candidate);
        print(_candidates[_mySavedList[i].candidate]);
        _savedListContainer.add(
            _buildCandidateList(_mySavedList[i].candidate)
        );
      }
      return Column(
        children: _savedListContainer,
      );
    }
    else if(_mySavedListLength == 0){
      return Container();
    }
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              radius: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      items: 20,
      period: Duration(seconds: 3),
      highlightColor: Color(0xFF1F1F1F),
      direction: SkeletonDirection.btt,
    );
  }

  Widget _buildCandidateList(List<Candidate> categoryCandidate){
    List<Widget> candidates = [];
    for(int i = 0; i < categoryCandidate.length; i++){
      candidates.add(Column(
        children: [
          _savedCandidateContainer(categoryCandidate[i]),
          SizedBox(height:24)
        ],
      ));
    }
    return Column(
      children: candidates,
    );
  }

  @override
  void initState() {
    _allSavedList();
    super.initState();
  }


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
                        _buildAllSavedList()
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

  Widget _savedCandidateContainer(Candidate candidate){
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${candidate.firstName}",
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
                    "${candidate.experience} YEARS EXPERIENCE",
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
//                  Text(
//                    "${candidate.availablity}",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      fontWeight: FontWeight.w400,
//                      fontFamily: 'Gelion',
//                      fontSize: 14,
//                      color: Color(0xFF717F88),
//                    ),
//                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    "${candidate.residence}",
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
