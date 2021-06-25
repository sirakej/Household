import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class MyPurchases extends StatefulWidget {
  static const String id = 'my_purchases';

  @override
  _MyPurchasesState createState() => _MyPurchasesState();
}

class _MyPurchasesState extends State<MyPurchases> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Purchases',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Gelion',
            fontSize: 19,
            color: Color(0xFF000000),
          ),
        ),
        leading: IconButton(
          icon:Icon(
            Icons.chevron_left,
            size: 30,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFFCFDFE),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFCFDFE),
      body: Container(

        width: SizeConfig.screenWidth,
        padding:EdgeInsets.only(left:24,right:24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'You’re only allowed to select a maximmum of 3\ncandidates per category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 12.6829,
                  color: Color(0xFF57565C),
                ),
              ),
            ),
            SizedBox(height: 33.9,),
            Text(
              'Jun 12',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF717F88),
              ),
            ),
            SizedBox(height: 14,),
            _buildPurchasesContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchasesContainer(){
    return Container(
      padding: EdgeInsets.only(top: 21,left: 16,bottom: 22,right:13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Color(0xFFEBF1F4),width: 1)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Purchase 1',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 13,),
              Row(
                children: [
                  Container(
                    width:300,
                    //width: SizeConfig.screenWidth,
                    height: 1,
                    color: Color(0xFF000000).withOpacity(0.1),
                  ),
                  Container()
                ],
              ),
              SizedBox(height: 13,),
              Row(
                children: [
                  Text(
                    '2 Gatemen',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 14,
                      color: Color(0xFF717F88),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
