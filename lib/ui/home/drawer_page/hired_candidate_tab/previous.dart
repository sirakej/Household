import 'package:flutter/material.dart';

class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 23,),
            _buildPreviousContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousContainer(){
    return Container(
      padding: EdgeInsets.only(left:16,top: 19,right: 0,bottom:19 ),
      color: Color(0xFFFFFFFF),
      child: Row(
        children: [
          Image.asset("" , width:60,height: 60,fit: BoxFit.contain,) ,
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
          )
        ],
      ),
    );
  }

}
