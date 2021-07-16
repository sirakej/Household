import 'package:householdexecutives_mobile/database/user-db-helper.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/model/hired-candidates.dart';
import 'package:householdexecutives_mobile/model/popular-category.dart';
import 'package:householdexecutives_mobile/model/saved-candidates.dart';
import 'package:householdexecutives_mobile/model/plans.dart';
import 'package:householdexecutives_mobile/model/scheduled-candidates.dart';
import 'package:householdexecutives_mobile/model/transaction.dart';
import 'package:householdexecutives_mobile/model/user.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
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
        token,
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

  /// This function gets all categories in the db without passing user token
  /// It returns a list of [Category]
  Future<List<Category>> getAllCategories() {
    var data = RestDataSource();
    Future<List<Category>> categories = data.getAllCategory();
    return categories;
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
    var data = RestDataSource();
    Future<List<Category>> categories = data.getCategory();
    return categories;
  }

  Future<List<PopularCategory>> getPopularCategoryFromDB({bool refresh}) async {
    List<PopularCategory> sortedCategories = [];
    var data = RestDataSource();
    Future<List<PopularCategory>> categories = data.getPopularCategory(refresh: refresh);
    await categories.then((value){
      sortedCategories.addAll(value);
      sortedCategories.sort((a, b) => (b.count).compareTo(a.count));
    }).catchError((e){
      throw e;
    });
    return sortedCategories;
  }

  Future<List<Candidate>> getRecommendedCandidates({bool refresh}) {
    var data = RestDataSource();
    Future<List<Candidate>> candidates = data.getRecommendedCandidate(refresh: refresh);
    return candidates;
  }

  /// Function to get all available plans in the database with
  /// the help of [AuthRestDataSource]
  /// It returns a list of [Candidate]
  Future<List<Candidate>> getAllCandidateFromDB(String id) {
    var data = RestDataSource();
    Future<List<Candidate>> candidates = data.getCandidate(id);
    return candidates;
  }

  Future<List<MySavedList>> getAllSavedListFromDB() {
    var data = RestDataSource();
    Future<List<MySavedList>> savedList = data.getSavedList();
    return savedList;
  }

  Future<List<HiredCandidates>> getAllHiredCandidatesFromDB() {
    var data = RestDataSource();
    Future<List<HiredCandidates>> savedList = data.getHiredCandidates();
    return savedList;
  }

  Future<List<ScheduledCandidates>> getAllScheduledCandidatesFromDB() {
    var data = RestDataSource();
    Future<List<ScheduledCandidates>> savedList = data.getScheduledCandidates();
    return savedList;
  }

  Future<List<Transaction>> getTransactionHistoryFromDB() {
    var data = AuthRestDataSource();
    Future<List<Transaction>> transactions = data.getTransactionHistory();
    return transactions;
  }

}