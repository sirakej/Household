/*class Saved {
  Saved({
    this.candidate,
    this.category,
  });

  List<String> candidate;
  String category;

  factory Saved.fromJson(Map<String, dynamic> json) => Saved(
    candidate: List<String>.from(json["candidate"].map((x) => x)),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "candidate": List<dynamic>.from(candidate.map((x) => x)),
    "category": category,
  };
}*/

import 'candidate.dart';
import 'plans.dart';

class SaveCandidates {

  SaveCandidates({
    this.candidatePlan,
    this.package,
    this.roles,
    this.category,
  });

  List<CandidatePlan> candidatePlan;
  Plan package;
  int roles;
  String category;

  Map<String, dynamic> toJson() => {
    "candidate_plan": List<dynamic>.from(candidatePlan.map((x) => x.toJson())),
    "package": package.toJson(),
    "roles": roles,
    "category": category,
  };
}

class CandidatePlan {

  CandidatePlan({
    this.candidate,
  });

  Candidate candidate;

  Map<String, dynamic> toJson() => {
    "candidate": candidate.id,
    "hire_plan": candidate.availability.toJson(),
  };
}
