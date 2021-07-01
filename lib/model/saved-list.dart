import 'candidate-availability.dart';
import 'candidate.dart';
import 'category-class.dart';
import 'plans.dart';
import 'transaction.dart';

class MySavedList {

  MySavedList({
    this.purchase,
    this.savedCategory,
  });

  Transaction purchase;
  List<SavedCategory> savedCategory;

  factory MySavedList.fromJson(Map<String, dynamic> json) => MySavedList(
    purchase: Transaction.fromJson(json["purchase"]),
    savedCategory: List<SavedCategory>.from(json["saved_category"].map((x) => SavedCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "purchase": purchase.toJson(),
    "saved_category": List<dynamic>.from(savedCategory.map((x) => x.toJson())),
  };
}

class SavedCategory {

  SavedCategory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.candidatePlan,
    this.user,
    this.category,
    this.getCategory,
    this.package,
    this.roles,
    this.interview,
    this.purchase,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  List<CandidatePlan> candidatePlan;
  String user;
  String category;
  CategoryClass getCategory;
  Plan package;
  int roles;
  bool interview;
  String purchase;

  factory SavedCategory.fromJson(Map<String, dynamic> json) => SavedCategory(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    candidatePlan: List<CandidatePlan>.from(json["candidate_plan"].map((x) => CandidatePlan.fromJson(x))),
    user: json["user"],
    category: json["category"],
    getCategory: CategoryClass.fromJson(json["get_category"]),
    package: Plan.fromJson(json["package"]),
    roles: json["roles"],
    interview: json["interview"],
    purchase: json["purchase"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "candidate_plan": List<dynamic>.from(candidatePlan.map((x) => x.toJson())),
    "user": user,
    "category": category,
    "get_category": getCategory.toJson(),
    "package": package.toJson(),
    "roles": roles,
    "interview": interview,
    "purchase": purchase,
  };

}

class CandidatePlan {

  CandidatePlan({
    this.candidate,
    this.getCandidate,
    this.hirePlan,
  });

  String candidate;
  Candidate getCandidate;
  Availability hirePlan;

  factory CandidatePlan.fromJson(Map<String, dynamic> json) => CandidatePlan(
    candidate: json["candidate"],
    getCandidate: Candidate.fromJson(json["get_candidate"]),
    hirePlan: Availability.fromJson(json["hire_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "candidate": candidate,
    "get_candidate": getCandidate.toJson(),
    "hire_plan": hirePlan.toJson(),
  };

}


