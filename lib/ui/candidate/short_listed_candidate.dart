import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';


class ShortListedCandidate extends StatefulWidget {
  static const String id = 'short_list_candidate';

  final Category category;

  final  List<Candidate> candidates;

  const ShortListedCandidate({
    Key key,
    @required this.category,
    @required this.candidates,
  }) : super(key: key);
  @override
  _ShortListedCandidateState createState() => _ShortListedCandidateState();
}

class _ShortListedCandidateState extends State<ShortListedCandidate> {
  int count = 1;

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, List<Candidate>> _candidates = {};

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, bool> _categoriesSelection = {};

  /// A List to hold the all the available categories
  List<Category> _categories = [];

  /// An Integer variable to hold the length of [_categories]
  int _categoriesLength;

  /// A List to hold the widgets of all the categories
  List<Widget> _categoriesList = [];


  /// Function to fetch all the available plans from the database to
  /// [allCategories]
  void _allCategories() async {
    Future<List<Category>> names = futureValue.getAllCategoryFromDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _categoriesLength = 0;
          _categories = [];
          _categoriesSelection = {};
          _candidates = {};
        });
      } else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _categories.addAll(value.reversed);
          _categoriesLength = value.length;
          for(int i = 0; i < value.length; i++){
            _categoriesSelection[value[i]] = false;
            _candidates[value[i]] = [];
          }
        });
      }
    }).catchError((error){
      print(error);
      Constants.showError(context, error);
    });
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Color(0xFF000000),
                      ),

                    ),
                    Text(
                      'Shortlisted Candidates',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 19,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Container(),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'select up to 3 candidates per category to\ninterview and make a final choice after',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 12.6829,
                    color: Color(0xFF57565C),
                  ),
                ),
                SizedBox(height: 29.39),
                Container(
                  width: SizeConfig.screenWidth,
                  height: 0.5,
                  color: Color(0xFFC4CDD5),
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF00A69D)
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xFFFFFFFF),
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height:17),
                          _buildShortListedContainer(),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              InkWell(
                            onTap: (){
                                      if(count<=1){
                                      }else{
                                        setState(() {
                                          count--;
                                        });
                                      }
                            },
                            child: Container(
                              width: 62,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFDFE3E8),
                                  width: 1,
                                ),
                                color: Color(0xFFDFE3E8),
                              ),
                              child: Center(
                                child: Container(
                                  height:2,
                                  width: 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF000000),
                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                ),
                              ),
                            ),
                          ),
                              Expanded(
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFDDDDDD),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "$count",
                                  style: TextStyle(
                                    color: Color(0xFF001845),
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    fontWeight:FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                              InkWell(
                            onTap: (){
                              setState(() {
                                count++;
                              });
                              },
                            child: Container(
                              width: 62,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF00A69D),
                                  width: 1,
                                ),
                                color: Color(0xFF00A69D),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 17,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select A Package',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 12.6829,
                                  color: Color(0xFF042538),
                                ),
                              ),
                              Text(
                                'Learn More',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 12.6829,
                                  color: Color(0xFF00A69D),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.radio_button_unchecked,
                                      size: 12.83,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Standard',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 12.6829,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Text(
                                        'N200,000',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 20,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.radio_button_unchecked,
                                      size: 12.83,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Premium',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 12.6829,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Text(
                                        'N400,000',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 20,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 24,right:24),
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  minWidth: SizeConfig.screenWidth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.only(top:18 ,bottom: 18),
                  onPressed:(){
//                  Navigator.push(context,
//                      CupertinoPageRoute(builder: (_){
//                        return Packages(
//                          candidates: _candidates,
//                        );
//                      })
//                  );
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShortListedContainer(){
    return Container(
      padding: EdgeInsets.only(left:16,top: 19,right: 0,bottom:19 ),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: Color(0xFFEBF1F4), width: 1)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/icons/butler.png" , width:60,height: 60,fit: BoxFit.contain,) ,
          SizedBox(width: 17,),
          Column(
            children: [
              Text(
                "Andrew Odeka",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF5D6970),
                ),
              ),
              SizedBox(height:4,),
              Text(
                "Saved Candidates",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFFF7941D),
                ),
              ),
              SizedBox(height:4,),
              Row(
                children: [
                  Text(
                    "Custom",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFFC4C4C4),
                    ),
                  ),
                  SizedBox(width: 7,),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(width: 7,),
                  Text(
                    "Lagos",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFFC4C4C4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: (){},
            child:Text(
              "Remove",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                fontSize: 11,
                color: Color(0xFFE93E3A),
              ),
            ),
          )
        ],
      ),
    );
  }
}
