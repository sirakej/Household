import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/mySavedList.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'error-handler.dart';
import 'network_util.dart';

class RestDataSource {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  NetworkHelper _netUtil = NetworkHelper();

  static final GET_SAVED_LIST = BASE_URL + "user/savedcandidate";

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

}