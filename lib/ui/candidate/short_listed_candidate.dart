import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';

class ShortListedCandidate extends StatefulWidget {

  static const String id = 'short_list_candidate';

  final Map<Category, List<Candidate>> candidates;

  const ShortListedCandidate({
    Key key,
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

  /*/// Function to fetch all the available plans from the database to
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
  }*/

  /// A List to hold the all the available plans
  List<Plan> _plans = [];

  /// A List to hold the all the available plans
  Map<Plan, bool> _plansToSelect = {};

  /// An Integer variable to hold the length of [_plans]
  int _plansLength;

  Map<Category, Map<Plan, bool>> _selectedPlans = {};

  /// Function to fetch all the available plans from the database to
  /// [allCategories]
  void _allPlans() async {
    Future<List<Plan>> names = futureValue.getAllPlansDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _plansLength = 0;
          _plans = [];
          _plansToSelect = {};
        });
      }
      else if (value.length > 0){
        _plansLength = value.length;
        if(!mounted)return;
        setState(() {
          _plans.addAll(value);
          _plansLength = value.length;
          for(int i = 0; i < value.length; i++){
            _plansToSelect[value[i]] = false;
          }
        });
      }
    }).catchError((e){
      print(e);
      Constants.showError(context, e);
    });
  }

  Widget _buildShortListedList(){
    print(_selectedPlans);
    List<Widget> categoriesList = [];
    widget.candidates.forEach((k, v) {
      if(v.isNotEmpty){
        Map<Plan, bool> plansToSelect = _plansToSelect;
        _selectedPlans[k] = plansToSelect;
        List<Widget> candidateList = [];
        for(int i = 0; i < v.length; i++){
          candidateList.add(
            Container(
              padding: EdgeInsets.fromLTRB(4, 8, 18, 21),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: Color(0xFFEBF1F4), width: 1)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //padding: EdgeInsets.only(top: 11),
                        height: 57,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Image.network(
                          v[i].profileImage,
                          height: 57,
                          width: 72,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace){
                            return Container();
                          },
                        ),
                      ),
                      SizedBox(width: 17),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            v[i].firstName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF5D6970),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${v[i].experience} ${v[i].experience > 1 ? 'Years' : 'Year'} Experience",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFFF7941D),
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                v[i].availability.title,
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
                                v[i].origin,
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
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
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
                    ),
                  )
                ],
              ),
            ),
          );
        }
        List<Widget> planContainer = [];
        for(int i = 0; i < _plans.length; i++){
          planContainer.add(
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      print(k.category.name);
                      print(_selectedPlans[k.category.name]);
                      setState(() {
                        _selectedPlans[k].forEach((key, value) {
                          if(key.title == _plans[i].title){
                            _selectedPlans[k][key] = true;
                          }
                          else {
                            _selectedPlans[k][key] = false;
                          }
                        });
                      });
                    },
                    icon: Icon(
                      _selectedPlans[k][_plans[i]]
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 12.83,
                      color: _selectedPlans[k][_plans[i]]
                          ? Color(0xFF00A69D)
                          : Color(0xFF000000),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _plans[i].title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 12.6829,
                          color: Color(0xFF717F88),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        _plans[i].price != null ? Constants.money(double.parse(_plans[i].price), 'N') : '',
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
              )
          );
        }
        categoriesList.add(
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hire a ${k.category.name}",
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
                SizedBox(height: 17),
                Column(children: candidateList),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFDFE3E8),
                        onPrimary: Color(0xFF000000),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      onPressed: (){
                        if(count > 1){
                          if(!mounted)return;
                          setState(() {
                            count--;
                          });
                        }
                      },
                      child: Container(
                        width: 42,
                        height: 50,
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
                        child: Center(
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
                        )
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF00A69D),
                        onPrimary: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      onPressed: (){
                        if(!mounted)return;
                        setState(() {
                          count++;
                        });
                      },
                      child: Container(
                        width: 42,
                        height: 50,
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
                SizedBox(height: 12),
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
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: planContainer
                ),
                SizedBox(height: 18),
              ],
            )
        );
      }
    });
    return Column(children: categoriesList);
  }

  @override
  void initState() {
    _allPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Color(0xFF000000),
                    ),

                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Shortlisted Candidates',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 19,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
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
            SizedBox(height: 36.39),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildShortListedList(),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF00A69D),
                        onPrimary: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      onPressed:(){
                        /*Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return Packages(
                          candidates: _candidates,
                        );
                      })
                    );*/
                      },
                      child: Container(
                        height: 56,
                        width: SizeConfig.screenWidth,
                        child: Center(
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
                    ),
                  ],
                )
              )
            ),
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
