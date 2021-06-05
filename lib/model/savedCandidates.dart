class Saved {
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
}
