import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/model/saved-list.dart';
import 'package:householdexecutives_mobile/model/scheduled-candidates.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'error-handler.dart';
import 'network-util.dart';

class RestDataSource {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  NetworkHelper _netUtil = NetworkHelper();

  static final GET_SAVED_LIST = BASE_URL + "user/savedcandidate";
  static final GET_HIRED_CANDIDATES = BASE_URL + "user/hire";
  static final GET_SCHEDULED_CANDIDATES = BASE_URL + "user/schedule";

  Future<List<MySavedList>> getSavedList() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if (value.token == null) {
        throw ("No user logged in");
      }
      userId = value.id;
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });
    List<MySavedList> savedList = [];
    String GET_SAVED_LIST_URL = GET_SAVED_LIST + "/$userId";
    return _netUtil.get(GET_SAVED_LIST_URL , headers: header).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      }
      else {
        var rest = res["data"] as List;
        savedList = rest.map<MySavedList>((json) => MySavedList.fromJson(json)).toList();
        return savedList;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<HiredCandidates>> getHiredCandidates() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if (value.token == null) {
        throw ("No user logged in");
      }
      userId = value.id;
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });
    List<HiredCandidates> candidates = [];
    String GET_HIRED_CANDIDATES_URL = GET_HIRED_CANDIDATES + "/$userId";
    return _netUtil.get(GET_HIRED_CANDIDATES_URL , headers: header).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      }
      else {
        var rest = res["data"] as List;
        candidates = rest.map<HiredCandidates>((json) => HiredCandidates.fromJson(json)).toList();
        return candidates;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<ScheduledCandidates>> getScheduledCandidates() async {
    String userId;
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if (value.token == null) {
        throw ("No user logged in");
      }
      userId = value.id;
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });
    List<ScheduledCandidates> candidates = [];
    String GET_SCHEDULED_CANDIDATES_URL = GET_SCHEDULED_CANDIDATES + "/$userId";
    return _netUtil.get(GET_SCHEDULED_CANDIDATES_URL , headers: header).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      }
      else {
        var rest = res["data"] as List;
        candidates = rest.map<ScheduledCandidates>((json) => ScheduledCandidates.fromJson(json)).toList();
        return candidates;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

}