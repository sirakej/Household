
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class FindACandidate extends StatefulWidget {
  @override
  _FindACandidateState createState() => _FindACandidateState();
}

class _FindACandidateState extends State<FindACandidate> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 19,
                  color: Color(0xFF000000),
                ),
                onPressed:(){Navigator.pop(context);}
                ),
            SizedBox(height: 44,),
            Text(
              'Find a candidate!',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gelion',
                fontSize: 19,
                color: Color(0xFFF7941D),
              ),
            ),
            SizedBox(height: 8,),
            Text(
              'Login with your account details to\ncontinue.',
              textAlign: TextAlign.start,
              style: TextStyle(
                //letterSpacing: 1,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF57565C),
              ),
            ),
            SizedBox(height: 24,),

          ],
        ),
      ),
    );
  }
}
