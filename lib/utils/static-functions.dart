import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/database/user-db-helper.dart';
import 'package:householdexecutives_mobile/ui/registration/sign-in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions{

  static String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    print(duration.isNegative);
    if (duration.isNegative)
      return (date.toIso8601String() + "-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    else
      return (date.toIso8601String() + "+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
  }

  static void logOut(BuildContext context) async {
    var db = DatabaseHelper();
    await db.deleteUsers();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('loggedIn') ?? true;
    if(boolValue == true){
      await prefs.setBool('loggedIn', false);
      await prefs.setBool('fullRegistration', false);
      Navigator.of(context).pushNamedAndRemoveUntil(SignIn.id, (Route<dynamic> route) => false);
    }
  }

  /// Method to capitalize the first letter of each word in [string]
  static String capitalize(String string) {
    String result = '';

    if (string == null) {
      return '';
    }

    if (string.isEmpty) {
      return string;
    }

    else {
      List<String> values = string.split(' ');
      List<String> valuesToJoin = [];

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
      List<String> valuesToJoin = [];

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

  /// Convert a double [value] to a currency
  static String money(double value, String currency){
    final nf = NumberFormat("#,##0.00", "en_US");
    return '$currency${nf.format(value)}';
  }

  /// Function to show success message with [_showAlert]
  static showSuccess(BuildContext context, String message, {Function whereTo, bool shouldDismiss = true}) {
    Timer.run(() => _showAlert(
        context,
        message,
        Color(0xFFE2F8FF),
        CupertinoIcons.check_mark_circled_solid,
        Color.fromRGBO(91, 180, 107, 1),
        shouldDismiss,
        whereTo: whereTo
    ));
  }

  /// Function to show info message with [_showAlert]
  static showInfo(BuildContext context, String message, {bool shouldDismiss = true}) {
    Timer.run(() => _showAlert(
        context,
        message,
        Color(0xFFE7EDFB),
        Icons.info_outline,
        Color.fromRGBO(54, 105, 214, 1),
        shouldDismiss
    ));
  }

  /// Function to show error message with [_showAlert]
  static showError(BuildContext context, String message, {bool shouldDismiss = true}) {
    Timer.run(() => _showAlert(
        context,
        message,
        Color(0xFF000000).withOpacity(0.5),
        Icons.error_outline,
        Colors.white,
        shouldDismiss,
        textColor: Colors.white
    ));
  }

  /// Building a custom general dialog for my toast message with dynamic details
  static _showAlert(BuildContext context, String message, Color color, IconData icon, Color iconColor, bool shouldDismiss, {Color textColor, Function whereTo}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          if(shouldDismiss){
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context, rootNavigator: true).pop();
            }).then((value) {
              if(whereTo != null){
                whereTo();
              }
            });
          }
          return Material(
            type: MaterialType.transparency,
            //animationDuration: Duration(milliseconds: 3500),
            child: WillPopScope(
              onWillPop: () async => true,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 60),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10)
                          ),
                          color: color
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            icon,
                            size: 30,
                            color: iconColor,
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                message,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: textColor ?? Colors.black
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

}