import 'dart:async';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/plan.dart';
import 'package:householdexecutives_mobile/model/transaction.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'error-handler.dart';
import 'network-util.dart';

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
  static final GET_USER = BASE_URL + "user";
  static final UPDATE_USER_PROFILE = BASE_URL + "user/profile";
  static final UPDATE_USER_PASSWORD = BASE_URL + "user/profile/password";

  static final GET_PLANS = BASE_URL + "plan";
  static final VERIFY_PAYMENT = BASE_URL + 'plan/payment/verify';
  static final FETCH_PAYMENT_HISTORY = BASE_URL + 'plan/payment/history';


  /// A function that creates a new user with [name], [email]
  /// and [password] POST
  Future<User> signUp(String firstName, String surName, String email,
      String phoneNumber, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(SIGN_UP_URL, headers: header, body: {
      "first_name": firstName.trim(),
      "surname": surName.trim(),
      "email": email.toLowerCase().trim(),
      "phone_number": phoneNumber.trim(),
      "password": password
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      res["data"]["user"]["token"] = res["data"]["token"];
      return User.map(res["data"]["user"]);
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that authenticates a user with [email] and [password] POST.
  /// and returns a [User] model
  Future<User> signIn(String email, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(LOGIN_URL, headers: header, body: {
      "email": email.toLowerCase().trim(),
      "password": password
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      res["data"]["user"]["token"] = res["data"]["token"];
      return User.map(res["data"]["user"]);
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that reset user's password POST with [email]
  Future<dynamic> resetPassword(String email) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.post(RESET_PASSWORD_URL, headers: header, body: {
      "email": email.toLowerCase().trim()
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res["msg"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> updateProfile(String firstName, String surName, String email,
      String phoneNumber) async {
    String userId;
    String token;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      token = value.token;
      header = {"Authorization": "Bearer ${token}", "Content-Type": "application/json"};
    });
    String UPDATE_USER_PROFILE_URL = UPDATE_USER_PROFILE + '/$userId';
    return _netUtil.put(UPDATE_USER_PROFILE_URL, headers: header, body: {
      "first_name": firstName.trim(),
      "surname": surName.trim(),
      "email": email.toLowerCase().trim(),
      "phone_number": phoneNumber.trim(),
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      res["data"]["token"] = token;
      return User.map(res["data"]);
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> updatePassword(String oldPassword,
      String currentPassword) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String UPDATE_USER_PASSWORD_URL = UPDATE_USER_PASSWORD + '/$userId';
    return _netUtil.put(UPDATE_USER_PASSWORD_URL, headers: header, body: {
      "old_password": oldPassword,
      "password": currentPassword
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return User.map(res["data"]);
    }).catchError((e) {
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
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      token = value.token;
      header = {"Authorization": "Bearer ${token}", "Content-Type": "application/json"};
    });
    String GET_USER_URL = GET_USER + '/$userId';
    return _netUtil.get(GET_USER_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw (res["message"]);
      return { 'user': User.map(res["data"]), 'token': token };
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<Plan>> getPlans() async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    List<Plan> plans;
    return _netUtil.get(GET_PLANS, headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = res["data"] as List;
      plans = rest.map<Plan>((json) => Plan.fromJson(json)).toList();
      return plans;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that verifies payment POST with [reference]
  /// It returns a dynamic value message
  Future<dynamic> verifyPayment(String reference) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String VERIFY_PAYMENT_URL = VERIFY_PAYMENT + "/$userId/$reference";
    return _netUtil.get(VERIFY_PAYMENT_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw (res["msg"]);
      return res["msg"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches transaction history
  Future<List<Transaction>> getTransactionHistory() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    List<Transaction> transactions;
    String FETCH_PAYMENT_HISTORY_URL = FETCH_PAYMENT_HISTORY + '/$userId';
    return _netUtil.get(FETCH_PAYMENT_HISTORY_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = [];
      if(res["data"] != null) rest = res["data"] as List;
      transactions = rest.map<Transaction>((json) => Transaction.fromJson(json)).toList();
      return transactions;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

}
