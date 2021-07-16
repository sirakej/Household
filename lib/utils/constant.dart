import 'package:flutter/material.dart';

/// This variable holds the value of the API base url
/// const String BASE_URL = "https://householdexecutives.herokuapp.com/v1/";
const String BASE_URL = "https://backend.householdexecutivesltd.com/v1/";

const kFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFC4C4C4),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8))
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFC4C4C4),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8))
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF00A69D),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8))
  ),
);

const kPayCardDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0XFFC4C4C4),
      width: 1,
    ),

   // borderRadius: BorderRadius.all(Radius.circular(8))
  )
);

/// setting a constant [kTextBigFieldDecoration] for [InputDecoration] styles
const kTextBigFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFC3D3D4), width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFC3D3D4), width: 2.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);

const kPinFieldDecoration = InputDecoration(
  counterText: '',
 border: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);

const kPinTextStyle = TextStyle(
  color: Color(0xFF0000005),
  fontSize: 25,
  //fontFamily: "Bold",
);