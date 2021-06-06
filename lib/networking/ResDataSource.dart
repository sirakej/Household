
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/getSaveList.dart';
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

  Future<List<GetSaveList>> getSavedList(String id) async {
    Map<String, String> header;
    Future<User> user = futureValues.getCurrentUser();
    await user.then((value) {
      if (value.token == null) {
        throw ("No user logged in");
      }
      header = {
        "Authorization": "Bearer ${value.token}",
        "Content-Type": "application/json",
      };
    });

    List<GetSaveList> saveList;
    String GET_SAVED_LIST_URL = GET_SAVED_LIST + "/$id";
    return _netUtil.get(GET_SAVED_LIST_URL , headers: header).then((dynamic res) {
      if (res["error"]) {
        throw res["msg"];
      } else {
        var rest = res["data"] as List;
        saveList=
            rest.map<GetSaveList>((json) => GetSaveList.fromJson(json)).toList();
        return saveList;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

}