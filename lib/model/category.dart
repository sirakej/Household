import 'category_class.dart';

class Category {
  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.noOfCandidate,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  CategoryClass category;
  int noOfCandidate;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    category: CategoryClass.fromJson(json["category"]),
    noOfCandidate: json["no_of_candidate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": category.toJson(),
    "no_of_candidate": noOfCandidate,
  };
}

