import 'package:householdexecutives_mobile/database/user_db_helper.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
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

  /// Method to get the current [user] in the database using the
  /// [DatabaseHelper] class and update in the sqlite table
  Future<void> updateUser() async {
    var data = AuthRestDataSource();
    var db = DatabaseHelper();
    await data.getCurrentUser().then((value) async {
      User user = value['user'];
      String token = value['token'];
      var myUpdate = User(
        user.token,
        user.id,
        user.createdAt,
        user.updatedAt,
        user.firstName,
        user.surName,
        user.email,
        user.phoneNumber,
       // user.profileImage,

      );
      await db.updateUser(myUpdate);
    }).catchError((error) {
      print(error);
      throw error;
    });
  }


  /// Function to get all available plans in the database with
  /// the help of [AuthRestDataSource]
  /// It returns a list of [Plan]
  Future<List<Plan>> getAllPlansDB() {
    var data = AuthRestDataSource();
    Future<List<Plan>> plans = data.getPlans();
    return plans;
  }

  Future<List<Category>> getAllCategoryFromDB() {
    var data = AuthRestDataSource();
    Future<List<Category>> categories = data.getCategory();
    return categories;
  }

  /// Function to get all available plans in the database with
  /// the help of [AuthRestDataSource]
  /// It returns a list of [Candidate]
  Future<List<Candidate>> getAllCandidateFromDB(String id) {
    var data = AuthRestDataSource();
    Future<List<Candidate>> candidates = data.getCandidate(id);
    return candidates;
  }


}