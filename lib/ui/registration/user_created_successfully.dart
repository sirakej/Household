import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected_list.dart';
import 'package:householdexecutives_mobile/ui/home/home_screen.dart';
import 'package:householdexecutives_mobile/ui/candidate/find_a_category.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';


class UserCreatedSuccessfully extends StatefulWidget {
  static const String id = 'user_created_asuccessfully';
  @override
  _UserCreatedSuccessfullyState createState() => _UserCreatedSuccessfullyState();
}

class _UserCreatedSuccessfullyState extends State<UserCreatedSuccessfully> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:24, top:50 ,right: 24),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/splash_logo.png',
                  width: 152,
                  height:38,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 75,),
              Image.asset("assets/icons/circle check full.png",height:70,width:70,fit: BoxFit.contain,),
              SizedBox(height: 16,),
              Text(
                'Account Created!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gelion',
                  fontSize: 19,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                'Aliqua id fugiat nostrud irure ex duis ea\nquis id quis ad et. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 50,),
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
                        return SelectedList();
                      })
                  );
                },
                color: Color(0xFF00A69D).withOpacity(0.4),
                child: Text(
                  "Find Candidates",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFF00A69D),
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return HomeScreen();
                      })
                  );
                },
                child: Text(
                  "Go Home",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gelion',
                    fontSize: 16,
                    color: Color(0xFF00A69D),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
