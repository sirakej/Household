import 'candidate-availability.dart';
import 'candidate.dart';

class HiredCandidates {

  HiredCandidates({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.candidate,
    this.getCandidate,
    this.user,
    this.hirePlan,
    this.resumption,
    this.endDate,
    this.status,
    this.savedCategory,
    this.category,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String candidate;
  Candidate getCandidate;
  String user;
  Availability hirePlan;
  DateTime resumption;
  DateTime endDate;
  String status;
  String savedCategory;
  String category;

  factory HiredCandidates.fromJson(Map<String, dynamic> json) => HiredCandidates(
    id: json["_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    candidate: json["candidate"],
    getCandidate: Candidate.fromJson(json["get_candidate"]),
    user: json["user"],
    hirePlan: Availability.fromJson(json["hire_plan"]),
    resumption: DateTime.parse(json["resumption"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    savedCategory: json["saved_category"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "candidate": candidate,
    "get_candidate": getCandidate.toJson(),
    "user": user,
    "hire_plan": hirePlan.toJson(),
    "resumption": resumption.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": status,
    "saved_category": savedCategory,
    "category": category,
  };
}