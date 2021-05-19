import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';


class FutureValues{

  /// Method to get the current [getCurrentUser] in the database using the
  /// [DatabaseHelper] class
  Future<User> getCurrentUser() async {
    var dbHelper = DatabaseHelper();
    Future<User> user = dbHelper.getUser();
    return user;
  }


  /// Function to get all available plans in the database with
  /// the help of [AuthRestDataSource]
  /// It returns a list of [Category]
  Future<List<Category>> getAllCategoryFromDB() {
    var data = AuthRestDataSource();
    Future<List<Category>> categories = data.getCategory();
    return categories;
  }


}