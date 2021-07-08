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
    this.hires,
    this.interview,
    this.interviewDate,
    this.purchase,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  List<SavedCandidatePlan> candidatePlan;
  String user;
  String category;
  CategoryClass getCategory;
  Plan package;
  int roles;
  int hires;
  bool interview;
  DateTime interviewDate;
  String purchase;

  factory SavedCategory.fromJson(Map<String, dynamic> json) => SavedCategory(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    candidatePlan: List<SavedCandidatePlan>.from(json["candidate_plan"].map((x) => SavedCandidatePlan.fromJson(x))),
    user: json["user"],
    category: json["category"],
    getCategory: CategoryClass.fromJson(json["get_category"]),
    package: Plan.fromJson(json["package"]),
    roles: json["roles"],
    hires: json["hires"] ?? 0,
    interview: json["interview"],
    interviewDate: json["interview_date"] == null ? null : DateTime.parse(json["interview_date"]),
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
    "hires": hires ?? null,
    "interview": interview,
    "interview_date": interviewDate == null ? null : interviewDate.toIso8601String(),
    "purchase": purchase,
  };

}

class SavedCandidatePlan {

  SavedCandidatePlan({
    this.candidate,
    this.getCandidate,
    this.hirePlan,
    this.hired,
  });

  String candidate;
  Candidate getCandidate;
  Availability hirePlan;
  bool hired;

  factory SavedCandidatePlan.fromJson(Map<String, dynamic> json) => SavedCandidatePlan(
    candidate: json["candidate"],
    getCandidate: Candidate.fromJson(json["get_candidate"]),
    hirePlan: Availability.fromJson(json["hire_plan"]),
    hired: json["hired"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "candidate": candidate,
    "get_candidate": getCandidate.toJson(),
    "hire_plan": hirePlan.toJson(),
    "hired": hired,
  };

}


