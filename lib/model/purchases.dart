import 'candidate-availability.dart';
import 'category-class.dart';
import 'plan.dart';
import 'candidate.dart';

class Purchases {

  Purchases({
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
  int hires;

  factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    candidatePlan: List<CandidatePlan>.from(json["candidate_plan"].map((x) => CandidatePlan.fromJson(x))),
    user: json["user"],
    category: json["category"],
    getCategory: CategoryClass.fromJson(json["get_category"]),
    package: Plan.fromJson(json["package"]),
    roles: int.parse(json["roles"].toString()),
    hires: int.parse(json["hires"].toString()),
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
    "hires": hires,
  };
}

class CandidatePlan {

  CandidatePlan({
    this.candidate,
    this.getCandidate,
    this.hirePlan,
    this.interviewed,
    this.interviewDate,
    this.status,
  });

  String candidate;
  Candidate getCandidate;
  Availability hirePlan;
  bool interviewed;
  DateTime interviewDate;
  String status;

  factory CandidatePlan.fromJson(Map<String, dynamic> json) => CandidatePlan(
    candidate: json["candidate"],
    getCandidate: Candidate.fromJson(json["get_candidate"]),
    hirePlan: Availability.fromJson(json["hire_plan"]),
    interviewed: json["interviewed"],
    interviewDate: DateTime.parse(json["interview_date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "candidate": candidate,
    "get_candidate": getCandidate.toJson(),
    "hire_plan": hirePlan.toJson(),
    "interviewed": interviewed,
    "interview_date": interviewDate.toIso8601String(),
    "status": status,
  };

}