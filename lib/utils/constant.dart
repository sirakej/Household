import 'package:flutter/material.dart';

class Constants {

  /// Method to capitalize the first letter of each word in [string]
  static String capitalize(String string) {
    String result = '';

    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    else {
      List<String> values = string.split(' ');
      List<String> valuesToJoin = new List();

      if (values.length == 1) {
        result = string[0].toUpperCase() + string.substring(1);
      }
      else {
        for (int i = 0; i < values.length; i++) {
          if (values[i].isNotEmpty) {
            valuesToJoin.add(values[i][0].toUpperCase() + values[i].substring(1));
          }
        }
        result = valuesToJoin.join(' ');
      }
    }
    return result;
  }

  /// Method to get the first letter of each word in [string], maximum of 2
  /// letters to return
  static String profileName(String string) {
    String result = '';

    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    else {
      List<String> values = string.split(' ');
      List<String> valuesToJoin = List();

      if (values.length == 1) {
        result = string[0];
      }
      else {
        valuesToJoin.add(values[0][0].toUpperCase());
        valuesToJoin.add(values[1][0].toUpperCase());
        result = valuesToJoin.join(' ');
      }
    }
    return result;
  }

}

const kFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0XFFC4C4C4),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8))
  )
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