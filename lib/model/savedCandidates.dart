class SavedCandidate {
  SavedCandidate({
    this.user,
    this.candidate,
    this.category,
  });

  String user;
  List<String> candidate;
  String category;

  factory SavedCandidate.fromJson(Map<String, dynamic> json) => SavedCandidate(
    user: json["user"],
    candidate: List<String>.from(json["candidate"].map((x) => x)),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "candidate": List<dynamic>.from(candidate.map((x) => x)),
    "category": category,
  };
}
