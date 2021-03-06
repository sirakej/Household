import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/ui/registration/register-candidate-one.dart';
import 'package:householdexecutives_mobile/ui/registration/sign-in.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class OnBoard extends StatefulWidget {

  static const String id = 'onboard';

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  final int _numPages = 3;

  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  String mainText = '';

  String subText = '';

  int index = 0;

  Timer timer;

  onImageChange(int page) {
    index = page;
    setState(() {
      _indicator = Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < _numPages; i++)
              if (i == page) ...[_circleBar(true)] else _circleBar(false),
          ],
        ),
      );
    });
  }

  carousel() {
    if (index == 2) {
      index = 0;
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      index += 1;
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  Widget _indicator = AnimatedContainer(
    duration: Duration(milliseconds: 500),
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    height: 8.0,
    width: 8.0,
    decoration: BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
    ),
  );

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF).withOpacity(0.4),
          shape: BoxShape.circle,
        ));
  }

  /// A variable to hold if candidate button is to be shown
  bool _showCandidateButton = false;

  /// Function to check if candidate button is to be shown
  void _getShowCandidateButton() async {
    Future<dynamic> show = futureValue.showCandidateButton();
    await show.then((value) {
      if(!mounted)return;
      setState(() => _showCandidateButton = value);
    }).catchError((e){
      if(!mounted)return;
      setState(() => _showCandidateButton = false);
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(milliseconds: 3500),
          (timer) => carousel(),
    );
    _getShowCandidateButton();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onImageChange,
            children: <Widget>[
              Image.asset(
                "assets/icons/onboard1.png",
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
             Image.asset(
                "assets/icons/onboard2.png",
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
             Image.asset(
                "assets/icons/onboard3.png",
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(top: 50,left: 24,right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icons/onboard_logo.png",height:38 ,width:152 ,fit: BoxFit.contain,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Help Better Life',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gelion',
                          fontSize: 26,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        "The provision of professional craftsman,\ndomestic and allied services for the elite.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          height: 1.5,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(height: 26,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _indicator
                        ],
                      ),
                      SizedBox(height: 34),
                      FlatButton(
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Color(0xFF00A69D)
                          ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(top:18 ,bottom: 18),
                        onPressed:(){
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_){
                                return SignIn();
                              })
                          );
                        },
                        color: Color(0xFF00A69D).withOpacity(0.4),
                        child: Text(
                          "Hire A Candidate",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      !_showCandidateButton
                          ? Container()
                          : Center(
                        child: TextButton(
                          onPressed:(){
                            Navigator.pushNamed(context, RegisterCandidateOne.id);
                          },
                          child: Text(
                              "Register As A Candidate",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

}
