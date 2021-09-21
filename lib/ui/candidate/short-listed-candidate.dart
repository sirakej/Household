import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/plan.dart';
import 'package:householdexecutives_mobile/model/save-candidates.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/networking/paystack-webview.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/ui/packages.dart';
import 'package:householdexecutives_mobile/ui/successful-pay.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _ShortListedCandidateState extends State<ShortListedCandidate> with SingleTickerProviderStateMixin{

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  String _buttonText = "Proceed To Payment";

  /// A List to hold the all the available plans
  List<Plan> _plans = [];

  Map<Category, Map<Plan, bool>> _selectedPlans = {};

  /// A variable to hold a count to a category
  Map<Category, int> _counts = {};

  /// This variable holds the total price for the packages selected
  double _totalPrice = 0;

  /// Function to fetch all the available plans from the database to
  /// [allCategories]
  void _allPlans() async {
    Future<List<Plan>> names = futureValue.getAllPlansDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _plans = [];
          _selectedPlans = {};
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _plans.addAll(value);
          widget.candidates.forEach((k, v) {
            Map<Plan, bool> plan = {};
            for(int i = 0; i < value.length; i++){
               plan[value[i]] = false;
            }
            _selectedPlans[k] = plan;
          });
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// This function gets the total category counts into a Map [_counts]
  /// by storing the category model and value of 1 as default for roles to fill
  void _getCounts(){
    if(!mounted)return;
    setState(() {
      widget.candidates.forEach((key, value) {
        _counts[key] = 1;
      });
    });
  }

  /// This value holds the current selected category
  String _selectedCategory;

  /// This function get the total category and candidates from [widget.candidates]
  void _getTotalCategories(){
    List<String> _allCategories = [];
    if(!mounted)return;
    setState(() {
      widget.candidates.forEach((k, v) {
        if(v.isNotEmpty){
          _allCategories.add(k.category.singularName);
        }
      });
      if(_allCategories.length > 0){
        _selectedCategory = _allCategories.first;
      }
      else {
        if(!mounted)return;
        Navigator.pop(context);
      }
    });
  }

  /// This function returns the category name of category that has selected
  /// candidates under them
  Widget _buildTabCategories(){
    List<Widget> categoriesTab = [];
    setState(() {
      widget.candidates.forEach((k, v) {
        if(v.isNotEmpty){
          categoriesTab.add(
            InkWell(
              onTap: (){
                setState(() {
                  _selectedCategory = k.category.singularName;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: _selectedCategory == k.category.singularName
                        ? BorderSide(color: Color(0xFF00A69D), width: 2)
                        : BorderSide.none
                  )
                ),
                child: Center(
                  child: Text(
                    k.category.singularName,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: _selectedCategory == k.category.singularName
                            ? Color(0xFF00A69D)
                            : Color(0xFF717F88)
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: categoriesTab
    );
  }

  /// This function returns the candidates and package to be selected under
  /// each category
  Map<String, Widget> _buildShortListedList(){
    Map<String, Widget> categoriesList = {};
    widget.candidates.forEach((k, v) {
      if(v.isNotEmpty){
        List<Widget> candidateList = [];
        for(int i = 0; i < v.length; i++){
          candidateList.add(
            Container(
              padding: EdgeInsets.only(bottom: 27, top: 24),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFEBF1F4), width: 1)
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: v[i].profileImage,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            v[i].firstName + ' ' + v[i].lastName.split('').first.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF042538),
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            "${v[i].experience} ${v[i].experience > 1 ? 'Years' : 'Year'} Experience",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 12,
                              color: Color(0xFF9BA8B1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      if(!mounted)return;
                      setState(() {
                        widget.candidates[k].remove(v[i]);
                      });
                      _getTotalCategories();
                      _calculateTotalPrice();
                      setState(() { });
                    },
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFE93E3A),
                      size: 14,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        List<Widget> planContainer = [];
        if(_selectedPlans.isNotEmpty){
          _selectedPlans[k].forEach((key, value) {
            planContainer.add(
              InkWell(
                onTap: (){
                  if(!mounted)return;
                  setState(() {
                    _selectedPlans[k].forEach((x, y) {
                      if(x.id == key.id){
                        _selectedPlans[k][x] = true;
                      }
                      else {
                        _selectedPlans[k][x] = false;
                      }
                    });
                  });
                  _calculateTotalPrice();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 22, 15),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(color: value
                        ? Color(0xFF00A69D) : Color(0xFFEBF1F4),
                        width: 1
                    )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            value
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 12.83,
                            color: value
                                ? Color(0xFF00A69D)
                                : Color(0xFF000000),
                          ),
                          SizedBox(width: 15),
                          Text(
                            key.price != null ? Functions.money(double.parse(key.price), 'N') : '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 20,
                              color: Color(0xFF042538),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        key.title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 12,
                          color: Color(0xFF717F88),
                        ),
                      ),
                    ],
                  ),

                ),
              )
            );
          });
        }

        categoriesList[k.category.singularName] = SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Candidates to hire",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(width: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            if(_counts[k] > 1){
                              if(!mounted)return;
                              setState(() {
                                _counts[k] -= 1;
                              });
                            }
                            _calculateTotalPrice();
                          },
                          child: Container(
                            width: 29,
                            height: 29,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD5D9DE).withOpacity(0.4)
                            ),
                            child: Center(
                              child: Container(
                                height: 2,
                                width: 9.33,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Text(
                            "${_counts[k]}",
                            style: TextStyle(
                              color: Color(0xFF042538),
                              fontFamily: 'Gelion',
                              fontSize: 23,
                              fontWeight:FontWeight.normal,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(!mounted)return;
                            setState(() {
                              _counts[k] += 1;
                            });
                            _calculateTotalPrice();
                          },
                          child: Container(
                            width: 29,
                            height: 29,
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
                      ],
                    ),
                  ]
              ),
              SizedBox(height: 14),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 28),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEBF1F4), width: 1),
                ),
                child: Column(
                    children: [
                      Column(children: candidateList),
                      SizedBox(height: 18),
                      InkWell(
                        onTap: (){
                          if(v.length < (_counts[k] * 3)){
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (v.length < (_counts[k] * 3))
                                      ? Color(0xFF00A69D) : Color(0xFFC4CDD5)
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFFFFFFFF),
                                  size: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Add More To This Category",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: (v.length < (_counts[k] * 3))
                                    ? Color(0xFF00A69D) : Color(0xFFC4CDD5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 28, 20, 31),
                        color: Color(0xFFF4F7F9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select A Package',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF042538),
                              ),
                            ),
                            SizedBox(height: 5),
                            InkWell(
                              onTap: (){
                                if(_plans.isNotEmpty){
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (_){
                                        return Packages(
                                          plans: _plans,
                                        );
                                      })
                                  ).then((value) {
                                    if(value != null){
                                      if(!mounted)return;
                                      setState(() {
                                        _selectedPlans[k].forEach((x, y) {
                                          if(x.id == value.id){
                                            _selectedPlans[k][x] = true;
                                          }
                                          else {
                                            _selectedPlans[k][x] = false;
                                          }
                                        });
                                      });
                                      _calculateTotalPrice();
                                    }
                                  });
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/learn-more.png',
                                    width: 12,
                                    height: 12,
                                    fit: BoxFit.contain,
                                    color: Color(0xFFF7941D),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'What does this mean?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFFF7941D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 13),
                            Column(children: planContainer),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 200),
            ],
          ),
        );
      }
    });
    return categoriesList;
  }

  /// This variable holds the boolean value either the instruction modal is
  /// shown or not
  bool _shownPopup = false;

  /// This function removes the saved shortlisted candidates stored in shared
  /// preference
  void _removeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('checkoutCategory');
    await prefs.remove('checkoutCandidates');
    prefs.getString('instructions');
    if(prefs.getString('instructions') != 'done' && !_shownPopup){
      if(!mounted)return;
      setState(() { _shownPopup = true; });
      _buildInstructionsSheet(context);
    }
  }

  /// This function saves user's shortlisted candidates temporarily to shared
  /// preference
  /// 'checkoutCategory' key for key in [widget.candidates] and
  /// 'checkoutCandidates' key for value in [widget.candidates]
  void _saveList() async {
    _removeList();
    List<String> tempCategory = [];
    List<dynamic> tempCandidates = [];
    widget.candidates.forEach((key, value) {
      tempCategory.add(key.category.id);
      tempCandidates.add(List<dynamic>.from(value.map((x) => x.toJson())));
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkoutCategory', jsonEncode(tempCategory));
    await prefs.setString('checkoutCandidates', jsonEncode(tempCandidates));
  }

  /// Function to calculate the total price when user select a package into
  /// [_totalPrice]
  void _calculateTotalPrice(){
    if(!mounted)return;
    setState(() {
      try {
        _totalPrice = 0;
        _selectedPlans.forEach((key, value) {
          if(widget.candidates[key].isNotEmpty){
            value.forEach((k, v) {
              if(v){
                _totalPrice += (double.parse(k.price) * _counts[key]);
              }
            });
          }
        });
      } catch (e){
        _totalPrice = 0;
      }
    });
  }

  bool _showSpinner = false;

  @override
  void initState() {
    _saveList();
    super.initState();
    _getTotalCategories();
    _allPlans();
    _getCounts();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: AbsorbPointer(
        absorbing: _showSpinner,
        child: Scaffold(
          backgroundColor: Color(0xFFDFE3E8),
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context, widget.candidates);
              },
            ),
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Check Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 19,
                color: Color(0xFF000000),
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFFF),
                padding: EdgeInsets.only(bottom: 39.39),
                child: Text(
                  'These are your preferred candidates.\nPlease schedule Set/Note Interview Dates',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 12.6829,
                    color: Color(0xFF57565C),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: 51,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: _buildTabCategories(),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 22, 25, 0),
                  color: Color(0xFFFFFFFF),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: _buildShortListedList()[_selectedCategory],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            padding: EdgeInsets.fromLTRB(25, 22, 25, 30),
            color: Color(0xFFF4F7F9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF717F88),
                      ),
                    ),
                    Text(
                      Functions.money(_totalPrice, 'N'),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 20,
                        color: Color(0xFF042538),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Button(
                  onTap: (){
                    if(_buttonText == 'Pay'){
                      _pay();
                    }
                    else {
                      bool check = false;
                      widget.candidates.forEach((key, value) {
                        if(value.length > 0){
                          check = true;
                        }
                      });
                      if(check){
                        if(_validateRoles() == true){
                          if(_validatePlan() == true){
                            _saveCandidate();
                          }
                        }
                      }
                      else {
                        Functions.showInfo(context, "Go back and select your candidates");
                      }
                    }
                  },
                  buttonColor: Color(0xFF00A69D),
                  child: Center(
                    child: _showSpinner
                        ? CupertinoActivityIndicator(radius: 13)
                        : Text(
                      _buttonText,
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
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  _buildInstructionsSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: EdgeInsets.only(right: 24),
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 26,
                        height: 26,
                        child: FloatingActionButton(
                            elevation: 30,
                            backgroundColor: Color(0xFF00A69D).withOpacity(0.25),
                            shape:CircleBorder(),
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
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 40, 24, 48),
                    margin: EdgeInsets.only(top: 34),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight:Radius.circular(30)
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF7941D)
                          ),
                          child: Center(
                            child: Image.asset(
                                "assets/icons/info.png",
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "Instruction For Selection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 18,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: 19),
                        Container(
                          width: SizeConfig.screenWidth - 100,
                          child: Text(
                            "If you would require more than one candidate (from the three options selected) for this category, please indicate by increasing the number of candidates to hire.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 12.6829,
                              color: Color(0xFF57565C),
                            ),
                          ),
                        ),
                        SizedBox(height: 37),
                        Button(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                            child: Text(
                              "I Understand",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 29),
                        /*TextButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('instructions', 'done');
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Don’t Show Again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFFF7941D),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }
    );
  }

  bool _validateRoles(){
    bool result = true;
    bool checked = false;
    widget.candidates.forEach((key, value) {
      if(value.length > 0){
        if(!checked){
          if(value.length > (_counts[key] * 3)){
            _buildCountErrorDialog('${key.category.singularName}\'s category');
            result = false;
            checked = true;
          }
        }

      }
    });
    return result;
  }

  bool _validatePlan(){
    bool result = true;
    bool checked = false;
    _selectedPlans.forEach((key, value) {
      if(widget.candidates[key].length > 0){
        if(!(value.containsValue(true))){
          if(!checked){
            _buildPaymentErrorDialog("${key.category.singularName}\'s");
            result = false;
            checked = true;
          }
        }
      }
    });
    return result;
  }

  /// Function that shows an error dialog if roles to fill doesn't 
  /// match with the candidate
  Future<void> _buildCountErrorDialog(String name){
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 10.0,
        child: Container(
          width: 260,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF).withOpacity(0.91),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Note',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gelion',
                        color: Color(0xFF1D1D1D)
                    ),
                  )
              ),
              Container(
                width: 220,
                padding: EdgeInsets.only(top: 12, bottom: 11),
                child: Text(
                  "You are only allowed to select a maximum of 3 candidates per hire in a category so Increase the number of candidates to hire for $name to accommodate your candidates",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                  ),
                ),
              ),
              Container(
                width: 252,
                height: 1,
                color: Color(0xFF9C9C9C).withOpacity(0.44),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 11),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                            color: Color(0xFF1FD47D)
                        ),
                      ),
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

  /// Function that shows an error dialog if user has not selected payment 
  Future<void> _buildPaymentErrorDialog(String name){
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 10.0,
        child: Container(
          width: 260,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF).withOpacity(0.91),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Note',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gelion',
                        color: Color(0xFF1D1D1D)
                    ),
                  )
              ),
              Container(
                width: 220,
                padding: EdgeInsets.only(top: 12, bottom: 11),
                child: Text(
                  "Please select a plan for $name category",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                  ),
                ),
              ),
              Container(
                width: 252,
                height: 1,
                color: Color(0xFF9C9C9C).withOpacity(0.44),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 11),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gelion',
                            color: Color(0xFF1FD47D)
                        ),
                      ),
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

  dynamic _paymentDetails;

  void _saveCandidate() async{
    if(!mounted)return;
    setState(() { _showSpinner = true; });
    List<SaveCandidates> saved = [];
    widget.candidates.forEach((key, value) {
      if(value.length > 0){
        var val = SaveCandidates();
        val.category = key.category.id;
        val.roles = _counts[key];
        _selectedPlans[key].forEach((k, v) {
          if(v){ val.package = k; }
        });
        List<CandidatePlan> candidates = [];
        for(int i = 0; i < value.length; i++){
          var cand = CandidatePlan();
          cand.candidate = value[i];
          candidates.add(cand);
        }
        val.candidatePlan = candidates;
        saved.add(val);
      }
    });
    var api = RestDataSource();
    await api.saveCandidate(saved).then((value) {
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
        _buttonText = "Pay";
        _paymentDetails = value;
      });
      _pay();
    }).catchError((error) {
      if(!mounted)return;
      setState(() { _showSpinner = false; });
      Functions.showError(context, error);
    });
  }

  void _pay(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayStackView(
            checkout: _paymentDetails['checkout']
        ),
      ),
    ).then((val) {
      if(val == 'success'){
        if(!mounted)return;
        setState(() { _showSpinner = true; });
        _verifyPayment(_paymentDetails['reference'].toString());
      }
      else {
        if(!mounted)return;
        setState(() { _showSpinner = false; });
      }
    });
  }

  void _verifyPayment(String reference) async {
    if(!mounted) return;
    setState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    await api.verifyPayment(reference).then((value) {
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
        _buttonText = 'Proceed To Payment';
        _paymentDetails = null;
      });
      _removeList();
      Navigator.pushReplacementNamed(context, SuccessfulPay.id);
    }).catchError((error) {
      if(!mounted)return;
      setState(() { _showSpinner = false; });
      Functions.showError(context, error);
    });
  }

}
