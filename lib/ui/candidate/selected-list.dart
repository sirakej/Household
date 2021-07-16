import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected-category.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SelectedList extends StatefulWidget {

  static const String id = 'selected_list';

  @override
  _SelectedListState createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList> {

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
      Functions.showError(context, error);
    });
  }

  /// A function to build the list of all the categories
  Widget _buildAllCategoriesList() {
    if(_categories.length > 0 && _categories.isNotEmpty){
      _categoriesList.clear();
      for (int i = 0; i < _categories.length; i++){
        _categoriesList.add(
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
                      if(!mounted)return;
                      setState(() {
                        _categoriesSelection[_categories[i]] = !_categoriesSelection[_categories[i]];
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
                                "Hire a ${_categories[i].category.name}  ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              _candidates[_categories[i]].length > 0
                                  ? Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE93E3A)
                                ),
                                child: Center(
                                  child: Text(
                                    '${_candidates[_categories[i]].length}',
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
                            crossFadeState: _categoriesSelection[_categories[i]]
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
                          _candidates[_categories[i]].length > 0
                              ? Column(
                            children: [
                              _buildCandidateList(_candidates[_categories[i]]),
                              SizedBox(height: 32),
                              Center(
                                child: IconButton(
                                  iconSize: 32,
                                  onPressed: () {
                                    if(_candidates[_categories[i]].length < 3){
                                      print( _candidates[_categories[i]]);
                                      Navigator.push(context,
                                          CupertinoPageRoute(builder: (_){
                                            return SelectedCategory(
                                              category: _categories[i],
                                              candidates: _candidates[_categories[i]],
                                            );
                                          })
                                      ).then((value) {
                                        if(value != null){
                                          if(!mounted)return;
                                          setState(() {
                                            _candidates[_categories[i]].add(value);
                                          });
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: _candidates[_categories[i]].length >= 3
                                        ? Color(0xFFC4CDD5)
                                        : Color(0xFF00A69D),
                                  ),
                                ),
                              ),
                              SizedBox(height: 31),
                            ],
                          )
                              : _buildEmpty(_categories[i]),
                        ],
                      ),
                    ),
                    secondChild: Container(),
                    crossFadeState: _categoriesSelection[_categories[i]]
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 500),
                  ),
                ],
              ),
            )
        );
      }
      return Column(
        children: _categoriesList,
      );
    }
    else if(_categoriesLength == 0){
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

  List<Widget> _allSelectedContainer = [];

  Widget _buildEmpty(Category category){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 36),
        Text(
          'Click the  “+” button to\nadd candidates',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 16,
            color: Color(0xFF717F88),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: (){
            Navigator.push(context,
                CupertinoPageRoute(builder: (_){
                  return SelectedCategory(
                    category: category,
                    candidates: [],
                  );
                })
            ).then((value) {
              if(value != null){
                if(!mounted)return;
                setState(() {
                  _candidates[category].add(value);
                });
              }
            });
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF00A69D)
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Color(0xFFFFFFFF),
                size: 16,
              ),
            ),
          ),
        ),
        SizedBox(height: 42),
      ],
    );
  }

  Widget _buildCandidateList(List<Candidate> categoryCandidate){
    List<Widget> candidates = [];
    for(int i = 0; i < categoryCandidate.length; i++){
      candidates.add(_buildCandidateContainer(categoryCandidate[i]));
    }
    return Column(
      children: candidates,
    );
  }

  @override
  void initState() {
    _allCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
        child: Column(
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
                  'My List',
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
              'You’re only allowed to select a maximmum of 3\ncandidates per category',
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
            Container(
              height: SizeConfig.screenHeight - 280,
              child: SingleChildScrollView(
                child: _buildAllCategoriesList()
              )
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 24,right:24),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                minWidth: SizeConfig.screenWidth,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.only(top:18 ,bottom: 18),
                onPressed:(){

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
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateContainer(Candidate candidate){
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
                    "${candidate.firstName} (${candidate.gender})",
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
                    '${candidate.experience} Years Eperience',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFFF7941D),
                    ),
                  ),
//                  Text(
//                    "${candidate.availablity} . ${candidate.resedential}",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                      //letterSpacing: 1,
//                      fontWeight: FontWeight.w400,
//                      fontFamily: 'Gelion',
//                      fontSize: 12,
//                      color: Color(0xFF717F88),
//                    ),
//                  ),
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

}
