import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

class SentLinkPage extends StatefulWidget {

  static const String id = 'sent_link';

  final String email;

  const SentLinkPage({
    Key key,
    @required this.email
  }) : super(key: key);

  @override
  _SentLinkPageState createState() => _SentLinkPageState();
}

class _SentLinkPageState extends State<SentLinkPage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left:24, right: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/sent.png",
                  height: 112,
                  width: 112,
                  fit: BoxFit.contain
                ),
                SizedBox(height: 23),
                Text(
                  'Check Your Mail',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gelion',
                    fontSize: 19,
                    color: Color(0xFF57565C),
                  ),
                ),
                SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                      text: "We have sent a link to ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                      children: [
                        TextSpan(
                            text: "${widget.email}\n",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF57565C),
                            )
                        ),
                        TextSpan(text:"for your account recovery"),
                      ]
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 59),
                Button(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    /*Navigator.push(context,
                        CupertinoPageRoute(builder: (_){
                          return CreateNewPassword();
                        })
                    );*/
                  },
                  buttonColor: Color(0xFF00A69D),
                  child: Center(
                    child: Text(
                      "Done",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Did not receive the email ? Check your spam folder",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "or ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF57565C),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "try another email address",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gelion',
                              fontSize: 14,
                              color: Color(0xFF00A69D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
