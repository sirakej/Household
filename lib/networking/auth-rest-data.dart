import 'dart:async';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';

import 'error-handler.dart';
import 'network_util.dart';

/// A [AuthRestDataSource] class to do all the send request to the back end
/// and handle the result
class AuthRestDataSource {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  NetworkHelper _netUtil = NetworkHelper();

  static final SIGN_UP_URL = BASE_URL + "user/register";
  static final LOGIN_URL = BASE_URL + "user/login";
  static final RESET_PASSWORD_URL = BASE_URL + "user/resetpassword";
  static final CHANGE_PASSWORD = BASE_URL + "user/resetpassword/change";
  static final UPDATE_USER_PROFILE = BASE_URL + "/user/proifle";
  static final UPDATE_USER_PASSWORD = BASE_URL + "/user/proifle";
  static final LIST_USER = "";


  /// A function that creates a new user with [name], [email]
  /// and [password] POST
  Future<User> signUp(String firstName, String surName,String email,String phoneNumber, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(SIGN_UP_URL, headers: header, body: {
      "first_name": firstName.trim(),
      "surname": surName.trim(),
      "email": email.trim(),
      "phone_number": phoneNumber.trim(),
      "password": password
    }).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      } else {
        res["data"]["user"]["token"] = res["data"]["token"];
        return User.map(res["data"]["user"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that completes user sign up process with [type], [name], [email]
  /// [phone] and [password] PUT
//  Future<User> completeSignUp(String type, String name, String email, String phone, String address) async {
//    String userId;
//    Map<String, String> header;
//    String token;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      userId = value.id;
//      token = value.token;
//      header = {
//        "Authorization": "Bearer ${value.token}",
//        "Content-Type": "application/json",
//      };
//    });
//    String COMPLETE_SIGN_UP_URL = SIGN_UP_URL + '/$userId';
//    return _netUtil.put(COMPLETE_SIGN_UP_URL, headers: header, body: {
//      "type": type.trim(),
//      "other_name": name.trim(),
//      "other_email": email.trim(),
//      "other_phone_number": phone.trim(),
//      "other_address": address.trim()
//    }).then((dynamic res) {
//      if (res["error"]) {
//        throw res["msg"];
//      } else {
//        res["data"]["user"]["token"] = token;
//        return User.map(res["data"]["user"]);
//      }
//    }).catchError((e) {
//      errorHandler.handleError(e);
//    });
//  }

  /// A function that authenticates a user with [email] and [password] POST.
  /// and returns a [User] model
  Future<User> signIn(String email, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(LOGIN_URL, headers: header, body: {
      "email": email,
      "password": password
    }).then((dynamic res) {
      print(res["data"]);
      if (res["error"]) {
        throw res["msg"];
      } else {
        res["data"]["user"]["token"] = res["data"]["token"];
        return User.map(res["data"]["user"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

//  /// A function that reset user's password POST with [email]
//  Future<dynamic> resetPassword(String email) async{
//    Map<String, String> header = {"Content-Type": "application/json"};
//    return _netUtil.post(RESET_PASSWORD_URL, headers: header, body: {
//      "email": email
//    }).then((dynamic res) {
//      if(res["error"]){
//        throw res["msg"];
//      }else{
//        return res["msg"];
//      }
//    }).catchError((e){
//      errorHandler.handleError(e);
//    });
//  }
//
//  /// A function that changes user's password with [password] PUT
//  Future<dynamic> changePassword(String password) async {
//    String userId;
//    Map<String, String> header;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      userId = value.id;
//      header = {
//        "Authorization": "Bearer ${value.token}",
//        "Content-Type": "application/json",
//      };
//    });
//    String CHANGE_PASSWORD_URL = CHANGE_PASSWORD + '/$userId';
//    return _netUtil.put(CHANGE_PASSWORD_URL, headers: header, body: {
//      "password": password
//    }).then((dynamic res) {
//      if (res["error"]) {
//        throw res["msg"];
//      } else {
//        return User.map(res["data"]);
//      }
//    }).catchError((e) {
//      errorHandler.handleError(e);
//    });
//  }
//
//  /// A function that updates user's profiles with [password] PUT
//  Future<dynamic> updateProfile(String email, String firstName, String surname, String phone) async {
//    String userId;
//    Map<String, String> header;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      userId = value.id;
//      header = {
//        "Authorization": "Bearer ${value.token}",
//        "Content-Type": "application/json",
//      };
//    });
//    String UPDATE_USER_PROFILE_URL = UPDATE_USER_PROFILE + '/$userId';
//    return _netUtil.put(UPDATE_USER_PROFILE_URL, headers: header, body: {
//      "email": email,
//      "first_name": firstName,
//      "surname": surname,
//      "phone_number": phone
//    }).then((dynamic res) {
//      if (res["error"]) {
//        throw res["msg"];
//      } else {
//        return User.map(res["data"]);
//      }
//    }).catchError((e) {
//      errorHandler.handleError(e);
//    });
//  }
//
//  /// A function that fetches all the payments plan GET
//  Future<List<AllPaymentPlan>> getPaymentPlan() async {
//    Map<String, String> header;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      header = {
//        "Authorization": "Bearer ${value.token}",
//        "Content-Type": "application/json",
//      };
//    });
//    List<AllPaymentPlan> plans;
//    return _netUtil.get(PAYMENT_PLAN, headers: header).then((dynamic res) {
//      if(res["error"]){
//        throw res["msg"];
//      }else{
//        var rest = res["data"] as List;
//        plans = rest.map<AllPaymentPlan>((json) => AllPaymentPlan.fromJson(json)).toList();
//        return plans;
//      }
//    }).catchError((e){
//      errorHandler.handleError(e);
//    });
//  }
//
//  /// A function to create a free trial for user POST
//  Future<dynamic> createFreeTrial() async {
//    String userId;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      userId = value.id;
//    });
//    String PAYMENT_PLAN_URL = PAYMENT_PLAN + '/freetrial/$userId';
//    return _netUtil.post(PAYMENT_PLAN_URL).then((dynamic res) {
//      if (res["error"]) {
//        throw res["msg"];
//      } else {
//        return res["data"];
//      }
//    }).catchError((e) {
//      errorHandler.handleError(e);
//    });
//  }
//
//  /// A function to create a plan for a user POST
//  Future<AllPaymentPlan> createPlan(AllPaymentPlan plan) async {
//    String userId;
//    Future<User> user = futureValues.getCurrentUser();
//    await user.then((value) {
//      if(value.token == null){
//        throw ("No user logged in");
//      }
//      userId = value.id;
//    });
//    String PAYMENT_PLAN_URL = PAYMENT_PLAN + '/$userId';
//    return _netUtil.post(PAYMENT_PLAN_URL, body: {
//      "title": plan.title,
//      "detail": plan.detail,
//      "price": plan.price,
//      "duration": plan.duration
//    }).then((dynamic res) {
//      if (res["error"]) {
//        throw res["msg"];
//      } else {
//        return res["data"];
//      }
//    }).catchError((e) {
//      errorHandler.handleError(e);
//    });
//  }

}
