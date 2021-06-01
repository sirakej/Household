import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
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

  static final UPDATE_USER_PROFILE = BASE_URL + "user/profile";
  static final UPDATE_USER_PASSWORD = BASE_URL + "user/profile/password";

  static final GET_CATEGORY = BASE_URL + "category";
  static final GET_CANDIDATE = BASE_URL + "candidate";

  static final GET_USER = BASE_URL + "user";
  static final GET_PLANS = BASE_URL + "plan";

  static final INITIALIZE_PAYMENT = BASE_URL + 'plan/payment';
  static final VERIFY_PAYMENT = BASE_URL + 'plan/payment/verify';

  static final SAVED_CANDIDATE = BASE_URL + 'candidate/saved';


  //static final LIST_USER = "";


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

  /// A function that reset user's password POST with [email]
  Future<dynamic> resetPassword(String email) async{
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(RESET_PASSWORD_URL, headers: header, body: {
      "email": email
    }).then((dynamic res) {
      if(res["error"]){
        throw res["msg"];
      }else{
        return res["msg"];
      }
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

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

  Future<dynamic> updateProfile(String firstName, String surName,String email,String phoneNumber) async {
    String userId;
    String token;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      token = value.token;
      header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    });
    String UPDATE_USER_PROFILE_URL = UPDATE_USER_PROFILE + '/$userId';
    return _netUtil.put(UPDATE_USER_PROFILE_URL, headers: header, body: {
      "first_name": firstName.trim(),
      "surname": surName.trim(),
      "email": email.trim(),
      "phone_number": phoneNumber.trim(),
    }).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      } else {
        res["data"]["token"] = token;
        return User.map(res["data"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> updatePassword(String oldPassword, String currentPassword) async{
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });
    String UPDATE_USER_PASSWORD_URL = UPDATE_USER_PASSWORD + '/$userId';
    return _netUtil.put(UPDATE_USER_PASSWORD_URL, headers: header, body: {
      "old_password": oldPassword,
      "password":currentPassword
    }).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      } else {
        return User.map(res["data"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches all categories
  Future<List<Category>> getCategory() async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });
    List<Category> categories;
    return _netUtil.get(GET_CATEGORY, headers: header).then((dynamic res) {
      if(res["error"]){
        throw res["msg"];
      }else{
        var rest = res["data"] as List;
        categories = rest.map<Category>((json) => Category.fromJson(json)).toList();
        return categories;
      }
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }


  Future<List<Candidate>> getCandidate(String id) async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });

    List<Candidate> candidates;
    String GET_CANDIDATE_URL = GET_CANDIDATE + "/$id";
    return _netUtil.get(GET_CANDIDATE_URL, headers: header).then((dynamic res) {
      if(res["error"]){
        throw res["msg"];
      }else{
        var rest = res["data"] as List;
        candidates = rest.map<Candidate>((json) => Candidate.fromJson(json)).toList();
        return candidates;
      }
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches the particular current logged in user
  /// into a model of [User] GET.
  Future<dynamic> getCurrentUser() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    String token;
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      token = value.token;
      header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    });
    String GET_USER_URL = GET_USER + '/$userId';
    return _netUtil.get(GET_USER_URL, headers: header).then((dynamic res) {
      if(res["error"] == true){
        throw (res["message"]);
      }else{
        Map result = {
          'user': User.map(res["data"]),
          'token': token
        };
        return result;
      }
    }).catchError((e){
      print(e);
      errorHandler.handleError(e);
    });
  }

  Future<List<Plan>> getPlans() async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    String token;
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      token = value.token;
      header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    });
    List<Plan> plans;
    return _netUtil.get(GET_PLANS, headers: header).then((dynamic res) {
      if(res["error"]){
        throw res["msg"];
      }else{
        var rest = res["data"] as List;
        plans = rest.map<Plan>((json) => Plan.fromJson(json)).toList();
        return plans;
      }
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that initializes payment POST.
  /// with [amount]
  Future<dynamic> initializePayment(Plan plan) async{
    String userId;
    Map<dynamic, dynamic> data = Map();
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "content-Type": "application/json"};
    });
    String INITIALIZE_PAYMENT_URL = INITIALIZE_PAYMENT + '/$userId';
    return _netUtil.post(INITIALIZE_PAYMENT_URL, headers: header, body: {
      "plan": plan.toJson()
    }).then((dynamic res) {
      if(res["error"]){
        throw (res["msg"]);
      }else{
        data['access_code'] = res['data']['access_code'];
        data['checkout'] = res['data']['checkout'];
        data['reference'] = res['data']['reference'];
        return data;
      }
    }).catchError((e){
      print(e);
      if(e is SocketException){
        throw ("Unable to connect to the server, check your internet connection");
      }
      throw (e);
    });
  }

  /// A function that verifies payment POST with [reference]
  /// It returns a model of [Data]
  Future<dynamic> verifyPayment(String reference) async{
    String userId;
    Map<dynamic, dynamic> data = Map();
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "content-Type": "application/json"};
    });
    String VERIFY_PAYMENT_URL = VERIFY_PAYMENT + "/$userId/$reference";
    return _netUtil.get(VERIFY_PAYMENT_URL, headers: header).then((dynamic res) {
      if(res["error"]){
        throw (res["msg"]);
      }else{
        return res["msg"];
      }
    }).catchError((e){
      print(e);
      if(e is SocketException){
        throw ("Unable to connect to the server, check your internet connection");
      }
      throw (e);
    });
  }

  Future<dynamic> saveCandidate(String candidateId,String categoryId) async{
    String userId;
    String token;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value.token == null){
        throw ("No user logged in");
      }
      userId = value.id;
      token = value.token;
      header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    });
    String SAVED_CANDIDATE_URL = SAVED_CANDIDATE + '/$userId';
    return _netUtil.put(SAVED_CANDIDATE_URL, headers: header, body: {
      "user":userId,
      "candidate":[candidateId],
      "category":categoryId
    }).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      } else {
        res["data"]["token"] = token;
        return User.map(res["data"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


}
