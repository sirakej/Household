import 'candidate.dart';

class MySavedList {

  MySavedList({
    this.candidate,
    this.user,
    this.category,
  });

  List<Candidate> candidate;

  String user;

  SavedCategory category;

  factory MySavedList.fromJson(Map<String, dynamic> json) => MySavedList(
    candidate: List<Candidate>.from(json["candidate"].map((x) => Candidate.fromJson(x))),
    user: json["user"],
    category: SavedCategory.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "candidate": List<dynamic>.from(candidate.map((x) => x.toJson())),
    "user": user,
    "category": category.toJson(),
  };

}

class SavedCategory {
  SavedCategory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.image,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;
  String image;

  factory SavedCategory.fromJson(Map<String, dynamic> json) => SavedCategory(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "description": description,
    "image": image,
  };
}

