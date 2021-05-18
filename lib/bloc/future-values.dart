import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/model/user.dart';


class FutureValues{

  /// Method to get the current [user] in the database using the
  /// [DatabaseHelper] class
  Future<User> getCurrentUser() async {
    var dbHelper = DatabaseHelper();
    Future<User> user = dbHelper.getUser();
    return user;
  }

  /// Function to get all available plans in the database with
  /// the help of [AuthRestDataSource]
  /// It returns a list of [AllPaymentPlan]
//  Future<List<AllPaymentPlan>> getAllPaymentPlanFromDB() {
//    var data = AuthRestDataSource();
//    Future<List<AllPaymentPlan>> plans = data.getPaymentPlan();
//    return plans;
//  }

}