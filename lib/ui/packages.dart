import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/successful_pay.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class Packages extends StatefulWidget {
  static const String id = 'packages';
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFF050729),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  'Precious',
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
                SizedBox(height:40),
                Container(
                  padding: EdgeInsets.only(left:16,top:14 , bottom:14 ),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                     // color: Color(0xFF00A69D).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          width: 1,
                          color: Color(0xFFF7941D)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 15,
                            color: Color(0xFFF7941D),
                          ),
                          SizedBox(width: 34,),
                          Text(
                            "Access to reports on three\ncandidates per category",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              //letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFFEBF1F4),
                            ),
                          ),
                      ],),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 15,
                            color: Color(0xFFF7941D),
                          ),
                          SizedBox(width: 34,),
                          Text(
                            "One Free Candidates Replacement",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              //letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFFEBF1F4),
                            ),
                          ),
                        ],),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 15,
                            color: Color(0xFFF7941D),
                          ),
                          SizedBox(width: 34,),
                          Text(
                            "One free quaterly medical report on\ncandidate after placement",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              //letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFFEBF1F4),
                            ),
                          ),
                        ],),
                    ],
                  ),
                ),
                SizedBox(height: 74,),
                Container(
                  padding: EdgeInsets.only(left:20,right:20,top:25 , bottom:25 ),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    // color: Color(0xFF00A69D).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          width: 1,
                          color: Color(0xFFF7941D)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "N 350,000.00",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          //letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 18,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      Text(
                        "One-time payment",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          //letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF99B9CF),
                        ),
                      ),
                    ],),
                ),
                SizedBox(height: 93,),
                FlatButton(
                  minWidth: SizeConfig.screenWidth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.only(top:18 ,bottom: 18),
                  onPressed:(){
                    _buildPaymentDialog();
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
              ],
            ),
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
              SizedBox(height:1),
              Text(
                "N350,000.00",
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gelion',
                  fontSize: 15,
                  color: Color(0xFF4EAF67),
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
                                "Pay N350,000",
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
}
