import 'candidate.dart';

class ScheduledCandidates {

  ScheduledCandidates({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.candidate,
    this.getCandidate,
    this.savedCategory,
    this.schedule,
    this.user,
    this.status
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String candidate;
  Candidate getCandidate;
  String savedCategory;
  DateTime schedule;
  String user;
  String status;

  factory ScheduledCandidates.fromJson(Map<String, dynamic> json) => ScheduledCandidates(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    candidate: json["candidate"],
    getCandidate: Candidate.fromJson(json["get_candidate"]),
    savedCategory: json["saved_category"],
    schedule: DateTime.parse(json["schedule"]),
    user: json["user"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "candidate": candidate,
    "get_candidate": getCandidate.toJson(),
    "saved_category": savedCategory,
    "schedule": schedule.toIso8601String(),
    "user": user,
    "status": status,
  };
}

