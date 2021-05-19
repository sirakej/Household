
class Category {
  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
  };
}
