import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class Packages extends StatefulWidget {

  static const String id = 'packages';

  final List<Plan> plans;
  
  const Packages({
    Key key,
    @required this.plans,
  }) : super(key: key);
  
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> with SingleTickerProviderStateMixin{

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// Variable to hold the paystack public key
  var publicKey = 'pk_live_f2db20f827f2de9c8646547ee71da0f51fa88483';

  List<Color> _randomColors = [
    Color(0xFFF7941D),
    Color(0xFF00A69D)
  ];

  /// A List to hold the widgets of all the plans
  List<Widget> _plansList = [];

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(widget.plans.length > 0 && widget.plans.isNotEmpty){
      _plansList.clear();
      for (int i = 0; i < widget.plans.length; i++) {
        /// A List to hold the all the available details
        List<Widget> details = [];

        for (int j = 0; j < widget.plans[i].details.length; j++) {
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
                  SizedBox(width: 34),
                  Expanded(
                    child: Text(
                      "${widget.plans[i].details[j]}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFFEBF1F4),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          );
        }
        _plansList.add(
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(left: 22, top: 16, bottom: 34),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: _randomColors[i].withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    width: 1,
                    color: _randomColors[i],
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.plans[i].title}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                    color: Color(0xFF99B9CF),
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(
                        "assets/icons/currency_icon.png",
                        width: 17,
                        height: 17,
                        fit: BoxFit.contain
                    ),
                    SizedBox(width: 9),
                    Text(
                      "${Functions.money(double.parse(widget.plans[i].price), '')}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gelion',
                        fontSize: 24,
                        color: Color(0xFFF7941D),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 17),
                Column(children: details)
              ],
            ),
          ),
        );
      }
      return Column(
        children: _plansList,
      );
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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF050729),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Our Packages',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 14,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
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
                SizedBox(height: 7),
                Text(
                  "Please make the payment, after that you can enjoy\nall features and benefits.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gelion',
                    fontSize: 13,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 36),
                _buildList(),
                SizedBox(height: 42),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Function that initializes payment by calling
  /// [initializePayment] in the [RestDataSource] class
  /*void _initializePayment() async {
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
          setState(() { _showSpinner = true; });
         _verifyPayment(value['reference'].toString());
        }
        else {
          if(!mounted)return;
          setState(() { _showSpinner = false; });
        }
      });
    }).catchError((error) {
      Functions.showError(context, error);
    });
  }*/

}
