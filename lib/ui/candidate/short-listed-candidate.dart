import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
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

class _ShortListedCandidateState extends State<ShortListedCandidate> {

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

  void _getCounts(){
    if(!mounted)return;
    setState(() {
      widget.candidates.forEach((key, value) {
        _counts[key] = 1;
      });
    });
  }

  Widget _buildShortListedList(){
    List<Widget> categoriesList = [];
    widget.candidates.forEach((k, v) {
      if(v.isNotEmpty){
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
                        child: CachedNetworkImage(
                          imageUrl: v[i].profileImage,
                          height: 57,
                          width: 72,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(),
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
                  InkWell(
                    onTap: (){
                      if(!mounted)return;
                      setState(() {
                        widget.candidates[k].remove(v[i]);
                      });
                      _calculateTotalPrice();
                    },
                    child: Text(
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
            ),
          );
        }
        List<Widget> planContainer = [];
        if(_selectedPlans.isNotEmpty){
          _selectedPlans[k].forEach((key, value) {
            planContainer.add(
                TextButton(
                  onPressed: (){
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
                  child: Row(
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
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key.title ?? '',
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
                            key.price != null ? Functions.money(double.parse(key.price), 'N') : '',
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
                )
            );
          });
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
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
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
                            SizedBox(width: 5),
                            Text(
                              "Add",
                              style: TextStyle(
                                color: Color(0xFF00A69D),
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight:FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 17),
                Column(children: candidateList),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Roles to fill',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFDFE3E8),
                            onPrimary: Color(0xFF000000),
                            shadowColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)
                            ),
                          ),
                          onPressed: (){
                            if(_counts[k] > 1){
                              if(!mounted)return;
                              setState(() {
                                _counts[k] -= 1;
                              });
                            }
                            _calculateTotalPrice();
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
                                    "${_counts[k]}",
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
                            shadowColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)
                            ),
                          ),
                          onPressed: (){
                            if(!mounted)return;
                            setState(() {
                              _counts[k] += 1;
                            });
                            _calculateTotalPrice();
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
                  ],
                ),
                SizedBox(height: 15),
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
                    InkWell(
                      onTap: (){
                        if(_plans.isNotEmpty){
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_){
                                return Packages(
                                  plans: _plans,
                                );
                              })
                          );
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
                          ),
                          SizedBox(width: 5),
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

  /// This function removes the saved shortlisted candidates stored in shared
  /// preference
  void _removeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('checkoutCategory');
    await prefs.remove('checkoutCandidates');
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
    _allPlans();
    _getCounts();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 14, 25, 0),
        child: Column(
          children: [
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
                    SizedBox(height: 22),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 0.5,
                      color: Color(0xFFC4CDD5),
                    ),
                    SizedBox(height: 15),
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
                    SizedBox(height: 30),
                  ],
                )
              )
            ),
          ],
        ),
      ),
    );
  }

  bool _validateRoles(){
    bool result = true;
    bool checked = false;
    widget.candidates.forEach((key, value) {
      if(value.length > 0){
        if(!checked){
          if(value.length > (_counts[key] * 3)){
            _buildCountErrorDialog('${key.category.name}\'s category');
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
            _buildPaymentErrorDialog("${key.category.name}\'s");
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
                  "You are only allowed to select a maximum of 3 candidates per role in a category so Increase the number of roles to fill for $name to accommodate your candidates",
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
