

import 'package:householdexecutives_mobile/model/getSaveList.dart';
import 'package:householdexecutives_mobile/networking/ResDataSource.dart';

class FutureData{

  Future<List<GetSaveList>> getAllSavedLisFromDB(String id) {
    var data = RestDataSource();
    Future<List<GetSaveList>> savedList = data.getSavedList(id);
    return savedList;
  }

}