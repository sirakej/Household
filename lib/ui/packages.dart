import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
import 'package:householdexecutives_mobile/model/savedCandidates.dart';
import 'package:householdexecutives_mobile/ui/successful_pay.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/networking/paystack_webview.dart';

class Packages extends StatefulWidget {
  static const String id = 'packages';

  final  Map<Category, List<Candidate>> candidates;

  const Packages({
    Key key,
    @required this.candidates,
  }) : super(key: key);
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> with SingleTickerProviderStateMixin{
  TabController _tabController;
  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _cardNumberController = TextEditingController();

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// Variable to hold the paystack public key
  var publicKey = 'pk_live_f2db20f827f2de9c8646547ee71da0f51fa88483';

  /// A List to hold the all the available plans
  List<Plan> _plans = List();

  Plan _selectedPlan;

  /// An Integer variable to hold the length of [_plans]
  int _plansLength;

  bool _showSpinner = false;

  /// A List to hold the widgets of all the plans
  List<Widget> _plansList = [];

  Map<String,bool> _change = {};

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
          _change = {};
        });
      } else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _plans.addAll(value);
          _plansLength = value.length;
          for(int i = 0; i < value.length; i++){
            _change[value[i].title] = false;
          }
        });
      }
    }).catchError((error){
      print(error);
      Constants.showError(context, error.toString());
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_plans.length > 0 && _plans.isNotEmpty){
      _plansList.clear();
      for (int i = 0; i < _plans.length; i++) {
        /// A List to hold the all the available details
        List<Widget> details = List();

        for (int j = 0; j < _plans[i].details.length; j++) {
          details.add(
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_outlined,
                    size: 15,
                    color: Color(0xFFFFFFFF),
                  ),
                  SizedBox(width: 34,),
                  Expanded(
                    child: Text(
                      "${_plans[i].details[j]}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFFEBF1F4),
                      ),
                    ),
                  ),
                ],),
            ),
          );
        }
        _plansList.add(
          Column(
            children: [
              InkWell(
                onTap: (){
                 setState(() {
                   _selectedPlan = _plans[i];
                   _change[_plans[i].title] = true;
                   _change.forEach((key, value) {
                     if(key != _plans[i].title){
                       _change[key] = false;
                     }
                   });
                 });
                },
                child: Container(
                  //margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(left: 22, top: 16, bottom: 34),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      color: !_change[_plans[i].title]
                          ? Color(0xFFF7941D).withOpacity(0.06)
                          : Color(0xFF00A69D).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          width: 1,
                          color:  !_change[_plans[i].title]
                              ? Color(0xFFF7941D)
                              : Color(0xFF00A69D)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_plans[i].title}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF99B9CF),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Image.asset("assets/icons/currency_icon.png", width: 17,
                              height: 17,
                              fit: BoxFit.contain),
                          SizedBox(width: 9,),
                          Text(
                            "${_plans[i].price}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              //letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gelion',
                              fontSize: 24,
                              color: Color(0xFFF7941D),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17,),
                      Column(
                        children: details
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        );
      }

      return Column(
        children: _plansList,
      );
    }
    else if(_plansLength == 0){
      return Container();
    }
    return Center(child: CupertinoActivityIndicator(radius: 15));
  }

  /// String variable to hold the current name of the user
  String _firstName = '';

  /// Setting the current user logged in to [_firstName]
  void _getCurrentUser() async {
    await futureValue.getCurrentUser().then((user) {
      if(!mounted)return;
      setState(() {
        _firstName = user.firstName;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _allPlans();
    print(_allPlans);

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF050729),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24,right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 19,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed:(){Navigator.pop(context);}
                  ),
                  SizedBox(width: 24,),
                  Text(
                    "Our Packages",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32,),
              Text(
                '$_firstName',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gelion',
                  fontSize: 25,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 7,),
              Text(
                "Please make the payment, after that you can enjoy\nall features and benefits.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 13,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height:10),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 26,),
                      _buildList(),
//                      Container(
//                        padding: EdgeInsets.only(left:22,top:16 , bottom:34 ),
//                        width: SizeConfig.screenWidth,
//                        decoration: BoxDecoration(
//                           color: Color(0xFF00A69D).withOpacity(0.08),
//                            borderRadius: BorderRadius.circular(6),
//                            border: Border.all(
//                                width: 1,
//                                color: Color(0xFF00A69D)
//                            )
//                        ),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              "Premium Package",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                fontWeight: FontWeight.w400,
//                                fontFamily: 'Gelion',
//                                fontSize: 14,
//                                color: Color(0xFF99B9CF),
//                              ),
//                            ),
//                            SizedBox(height: 6,),
//                            Row(
//                              children: [
//                                Image.asset("assets/icons/currency_icon.png",width:17,height:17 ,fit:BoxFit.contain),
//                                SizedBox(width: 9,),
//                                Text(
//                                  "89,500.00",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w700,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 24,
//                                    color: Color(0xFFF7941D),
//                                  ),
//                                ),
//                              ],
//                            ),
//                            SizedBox(height: 17,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "3 Candidate Profiles for Interview l\n1 Preferred Candidate Selection",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Primary Due Diligence",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Background Check Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Guarantors Verification Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Identity Verification Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Medical Screening Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Basic Etiquette Training",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "1 Month Handholding Period",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "1 Free Post-Employment Replacement",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                          ],
//                        ),
//                      ),
//                      SizedBox(height: 24,),
//                      Container(
//                        padding: EdgeInsets.only(left:22,top:16 , bottom:34 ),
//                        width: SizeConfig.screenWidth,
//                        decoration: BoxDecoration(
//                            color: Color(0xFFF7941D).withOpacity(0.06),
//                            borderRadius: BorderRadius.circular(6),
//                            border: Border.all(
//                                width: 1,
//                                color: Color(0xFFF7941D)
//                            )
//                        ),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              "Standard Package",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                fontWeight: FontWeight.w400,
//                                fontFamily: 'Gelion',
//                                fontSize: 14,
//                                color: Color(0xFF99B9CF),
//                              ),
//                            ),
//                            SizedBox(height: 6,),
//                            Row(
//                              children: [
//                                Image.asset("assets/icons/currency_icon.png",width:17,height:17 ,fit:BoxFit.contain),
//                                SizedBox(width: 9,),
//                                Text(
//                                  "44,500.00",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w700,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 24,
//                                    color: Color(0xFFF7941D),
//                                  ),
//                                ),
//                              ],
//                            ),
//                            SizedBox(height: 17,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "3 Candidate Profiles for Interview l\n1 Preferred Candidate Selection",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Primary Due Diligence",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Background Check Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Guarantors Verification Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Identity Verification Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Medical Screening Report",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                            SizedBox(height: 12,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Icon(
//                                  Icons.arrow_forward_outlined,
//                                  size: 15,
//                                  color: Color(0xFFFFFFFF),
//                                ),
//                                SizedBox(width: 34,),
//                                Text(
//                                  "Basic Etiquette Training",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                    //letterSpacing: 1,
//                                    fontWeight: FontWeight.w400,
//                                    fontFamily: 'Gelion',
//                                    fontSize: 14,
//                                    color: Color(0xFFEBF1F4),
//                                  ),
//                                ),
//                              ],),
//                          ],
//                        ),
//                      ),
                      SizedBox(height: 42,),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){
                          if(_change.containsValue(true)){
                            _initializePayment();
                          }
                        },
                        color: Color(0xFF00A69D),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildPaymentDialog(){
    return showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      barrierColor: Color(0xFF070B22).withOpacity(0.9),
      builder: (_) => Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        child: Container(
          alignment: Alignment.topCenter,
          width: SizeConfig.screenWidth,
          height: 490,
          padding: EdgeInsets.only(top:13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/icons/stack.png" , height: 64,width: 64,fit: BoxFit.contain,),
              SizedBox(height:14),
              Text(
                "ayojide@gmail.com",
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gelion',
                  fontSize: 15,
                  color: Color(0xFF122933),
                ),
              ),
              SizedBox(height:21,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF959595).withOpacity(0.5),
                width: 1,
              )
            ),
            child: TabBar(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  0.0,
                ),
                color: Color(0xFFC4C4C4),
              ),
              labelColor: Color(0xFF000000),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gelio',
                fontSize: 10,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gelion',
                fontSize: 10,
              ),
              unselectedLabelColor: Color(0xFF000000),
              tabs: [
                Tab(
                  text: 'PAY WITH CARD',
                ),
                Tab(
                  text: 'PAY WITH BANK',
                ),
              ],
            ),
          ),
              Expanded(
                child: Container(
                  //width: SizeConfig.screenWidth-100,
                  decoration: BoxDecoration(
                    //color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 17,right: 17),
                        child: Column(
                          children: [
                            _buildSignIn(),
                            SizedBox(height: 24,),
                            FlatButton(
                              minWidth: SizeConfig.screenWidth,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)
                              ),
                              padding: EdgeInsets.only(top:10 ,bottom: 10),
                              onPressed:(){
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (_){
                                      return SuccessfulPay();
                                    })
                                );
                              },
                              color: Color(0xFF4EAF67),
                              child: Text(
                                "Pay",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: TextButton(
                                  onPressed:(){
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF717F88),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),

                      ),
                      Container(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 27,),
          Container(
            width: SizeConfig.screenWidth,
            child: TextFormField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              //textInputAction: TextInputAction.next,
              validator: (value){
                if(value.isEmpty){
                  return 'Enter card Number';
                }
                return null;
              },
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                color: Color(0xFF042538),
              ),
              decoration:kPayCardDecoration.copyWith(
                  hintText: 'CARD NUMBER\n0000 0000 0000 0000',
                  hintStyle:TextStyle(
                    color:Color(0xFF000000).withOpacity(0.4),
                    fontSize: 14,
                    fontFamily: 'Gelion',
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),
          ),
          SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.screenWidth/3.2,
                child: TextFormField(
                 // controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter card Number';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kPayCardDecoration.copyWith(
                      hintText: 'CVV\n123',
                      hintStyle:TextStyle(
                        color:Color(0xFF000000).withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth/3.2,
                child: TextFormField(
                //  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Expiry Date';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kPayCardDecoration.copyWith(
                      hintText: 'VALID TILL\nMM/YY',
                      hintStyle:TextStyle(
                        color:Color(0xFF000000).withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Function that initializes payment by calling
  /// [initializePayment] in the [RestDataSource] class
  void _initializePayment() async {
    if(!mounted) return;
    setState(() {
      _showSpinner = true;
    });
    var api = AuthRestDataSource();
    await api.initializePayment(_selectedPlan).then((value) {

      if(!mounted)return;
      setState(() { _showSpinner = false; });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PayStackView(
              checkout: value['checkout']
          ),
        ),
      ).then((val) {
        if(val == 'success'){
          if(!mounted)return;
          setState(() {
            _showSpinner = true;
          });
         _verifyPayment(value['reference'].toString());
        }
        else {
          if(!mounted)return;
          setState(() { _showSpinner = false; });
        }
      });
    }).catchError((error) {
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
      });
      Constants.showError(context, error.toString());
    });
  }

  void _verifyPayment(String reference) async {
    if(!mounted) return;
    setState(() {
      _showSpinner = true;
    });
    var api = AuthRestDataSource();
    await api.verifyPayment(reference).then((value) {
      _saveCandidate();
    }).catchError((error) {
      if(!mounted)return;
      setState(() {
        _showSpinner = false;
      });
      Constants.showError(context, error.toString());
    });
  }

void _saveCandidate() async{
  List<Saved> saved = [];
  widget.candidates.forEach((key, value) {
    if(value.length > 0){
      var val = Saved();
      val.category = key.id;
      List<String> id = [];
      for(int i = 0; i < value.length; i++){
        id.add(value[i].id);
      }
      val.candidate = id;
    }
  });
  var api = AuthRestDataSource();
  await api.saveCandidate(saved).then((value) {
    if(!mounted)return;
    setState(() { _showSpinner = false; });
    Navigator.pushReplacementNamed(context, SuccessfulPay.id);
  }).catchError((error) {
    if(!mounted)return;
    setState(() {
      _showSpinner = false;
    });
    Constants.showError(context, error.toString());
  });
}

}
