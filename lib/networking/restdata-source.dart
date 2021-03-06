import 'dart:convert';
import 'dart:io';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/ad-banner.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/create-candidate.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/model/popular-category.dart';
import 'package:householdexecutives_mobile/model/purchases.dart';
import 'package:householdexecutives_mobile/model/save-candidates.dart';
import 'package:householdexecutives_mobile/model/saved-candidates.dart';
import 'package:householdexecutives_mobile/model/scheduled-candidates.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:path_provider/path_provider.dart';
import 'error-handler.dart';
import 'network-util.dart';
import 'endpoints.dart';

class RestDataSource {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  NetworkHelper _netUtil = NetworkHelper();

  /// This function checks if a register as a candiate button is to be shown
  Future<dynamic> showCandidateButton() async {
    Map<String, String> header = {"Content-Type": "application/json"};
    return _netUtil.get(SHOW_CANDIDATE_BUTTON, headers: header).then((dynamic res) {
      if(res["error"]) throw res["msg"] ?? 'Error occurred';
      return res["data"];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  Future<AdBanner> getAdBanner({bool refresh}) async {
    String fileName = 'ad-banner.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if(refresh == false && file.existsSync()){
      final data = file.readAsStringSync();
      return AdBanner.fromJson(jsonDecode(jsonDecode(data)["data"]));
    }
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    return _netUtil.get(GET_AD_BANNER, headers: header).then((dynamic res) {
      if(res["error"]) throw (res["msg"]);
      file.writeAsStringSync(jsonEncode(res), flush: true, mode: FileMode.write);
      return AdBanner.fromJson(res["data"]);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches all categories without sending token in header
  Future<List<Category>> getAllCategory() async {
    List<Category> categories;
    return _netUtil.get(GET_CATEGORY_URL).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = res["data"] as List;
      categories = rest.map<Category>((json) => Category.fromJson(json)).toList();
      return categories;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches all categories
  Future<List<Category>> getCategory({bool refresh}) async {
    List<Category> categories;
    String fileName = 'all-categories.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if(refresh == false && file.existsSync()){
      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      var rest = res["data"] as List;
      categories = rest.map<Category>((json) => Category.fromJson(json)).toList();
      return categories;
    }
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    return _netUtil.get(CATEGORY_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      file.writeAsStringSync(jsonEncode(res), flush: true, mode: FileMode.write);
      var rest = res["data"] as List;
      categories = rest.map<Category>((json) => Category.fromJson(json)).toList();
      return categories;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that fetches popular categories
  Future<List<PopularCategory>> getPopularCategory({bool refresh}) async {
    List<PopularCategory> categories;
    String fileName = 'popular-categories.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if(refresh == false && file.existsSync()){
      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      var rest = res["data"] as List;
      categories = rest.map<PopularCategory>((json) => PopularCategory.fromJson(json)).toList();
      return categories;
    }
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    return _netUtil.get(POPULAR_CATEGORY, headers: header).then((dynamic res) {
      if(res["error"]) throw (res["msg"]);
      file.writeAsStringSync(jsonEncode(res), flush: true, mode: FileMode.write);
      var rest = res["data"] as List;
      categories = rest.map<PopularCategory>((json) => PopularCategory.fromJson(json)).toList();
      return categories;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  Future<List<Candidate>> getCandidate(String id) async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    List<Candidate> candidates;
    String GET_CANDIDATE_URL = CANDIDATE_URL + "/$id";
    return _netUtil.get(GET_CANDIDATE_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = res["data"] as List;
      candidates = rest.map<Candidate>((json) => Candidate.fromJson(json)).toList();
      return candidates;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<Candidate>> getRecommendedCandidate({bool refresh}) async {
    List<Candidate> candidates;
    String fileName = 'recommended-candidates.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if(refresh == false && file.existsSync()){
      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      var rest = res["data"] as List;
      candidates = rest.map<Candidate>((json) => Candidate.fromJson(json)).toList();
      return candidates;
    }

    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    return _netUtil.get(RECOMMENDED_CANDIDATE, headers: header).then((dynamic res) {
      if(res["error"]) throw (res["msg"]);
      file.writeAsStringSync(jsonEncode(res), flush: true, mode: FileMode.write);
      var rest = res["data"] as List;
      candidates = rest.map<Candidate>((json) => Candidate.fromJson(json)).toList();
      return candidates;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> registerCandidate(CreateCandidate createCandidate) async {
    Map<String, String> body;
    body = {
      "email": createCandidate.email,
      "first_name": createCandidate.firstName,
      "last_name": createCandidate.lastName,
      "age": createCandidate.age.toString(),
      "phone_number": createCandidate.phoneNumber,
      "service_area": createCandidate.origin,
      "tribe": createCandidate.tribe ?? '',
      "gender": createCandidate.gender,
      "experience": createCandidate.experience.toString(),
      "residence": createCandidate.residence,
      "religion": createCandidate.religion ?? '',
      "skill": createCandidate.skill,
      "previous_employer": createCandidate.previousEmployer,
      "previous_employer_position": createCandidate.previousEmployerPosition,
      "category": createCandidate.category,
      "availability": jsonEncode(createCandidate.availability.toJson())
    };
    return _netUtil.postForm(CANDIDATE_URL, createCandidate.image, body: body)
        .then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res['data'];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> saveCandidate(List<SaveCandidates> saved) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String SAVED_CANDIDATE_URL = SAVED_CANDIDATE + '/$userId';
    return _netUtil.put(SAVED_CANDIDATE_URL, headers: header, body: {
      "saved": saved
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res["data"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> updateCandidate(Candidate candidate, String savedId) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String UPDATE_CANDIDATE_URL = UPDATE_CANDIDATE + '/$userId/$savedId';
    return _netUtil.put(UPDATE_CANDIDATE_URL, headers: header, body: {
      "candidate": candidate.id,
      "hire_plan": candidate.availability.toJson()
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res["data"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> deleteCandidate(String savedCategoryId, String candidateId) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String DELETE_CANDIDATE_URL = UPDATE_CANDIDATE + '/$userId/$savedCategoryId/$candidateId';
    return _netUtil.delete(DELETE_CANDIDATE_URL, headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return 'Successfully deleted';
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<Purchases>> getPendingPurchases() async {
    List<Purchases> purchases = [];
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String GET_SAVED_LIST_URL = GET_SAVED_LIST + "/$userId";
    return _netUtil.get(GET_SAVED_LIST_URL , headers: header).then((dynamic res) {
      if(res["error"]) throw res["msg"];
      if(res["data"] != null){
        var rest = res["data"] as List;
        purchases = rest.map<Purchases>((json) => Purchases.fromJson(json)).toList();
      }
      return purchases;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<HiredCandidates>> getHiredCandidates() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    List<HiredCandidates> candidates = [];
    String GET_HIRED_CANDIDATES_URL = GET_HIRED_CANDIDATES + "/$userId";
    return _netUtil.get(GET_HIRED_CANDIDATES_URL , headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = res["data"] as List;
      candidates = rest.map<HiredCandidates>((json) => HiredCandidates.fromJson(json)).toList();
      return candidates;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<ScheduledCandidates>> getScheduledCandidates() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    List<ScheduledCandidates> candidates = [];
    String GET_SCHEDULED_CANDIDATES_URL = GET_SCHEDULED_CANDIDATES + "/$userId";
    return _netUtil.get(GET_SCHEDULED_CANDIDATES_URL , headers: header).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      var rest = res["data"] as List;
      candidates = rest.map<ScheduledCandidates>((json) => ScheduledCandidates.fromJson(json)).toList();
      return candidates;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that schedules interview for candidate PUT with [id] and [date]
  Future<dynamic> scheduleCandidate(String id, DateTime date) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String SCHEDULE_INTERVIEW_URL = SCHEDULE_INTERVIEW + '/$userId/$id';
    return _netUtil.put(SCHEDULE_INTERVIEW_URL, headers: header, body: {
      "interview_date": Functions.formatISOTime(date)
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res["data"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that hires a candidate POST with [savedCategoryId],
  /// [categoryId], [candidateId], [hire] and [date]
  Future<dynamic> hireCandidate(String savedCategoryId, String categoryId,
      Candidate candidate, DateTime date, dynamic hirePlan) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    String HIRE_CANDIDATE_URL = HIRE_CANDIDATE + '/$userId/${candidate.id}';
    return _netUtil.post(HIRE_CANDIDATE_URL, headers: header, body: {
      "category": categoryId,
      "saved_category": savedCategoryId,
      "hire_plan": hirePlan.toJson(),
      "resumption": Functions.formatISOTime(date)
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return res["data"];
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that reviews user's candidate POST with [candidateId],
  /// [categoryId], [review] and [rating]
  Future<dynamic> reviewCandidate(String candidateId, String categoryId, String hireId,
      String review, int rating) async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if(value?.token == null) throw ("You're unauthorized, log out and login back to continue");
      userId = value.id;
      header = {"Authorization": "Bearer ${value.token}", "Content-Type": "application/json"};
    });
    return _netUtil.post(CANDIDTE_REVIEW, headers: header, body: {
      "user": userId,
      "candidate": candidateId,
      "detail": review,
      "rating": rating,
      "category": categoryId,
      "hired_candidate": hireId
    }).then((dynamic res) {
      if (res["error"]) throw res["msg"];
      return 'Successful';
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

}