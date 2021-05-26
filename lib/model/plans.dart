
class Plan {
  Plan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.price,
    this.details,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String price;
  List<String> details;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
    price: json["price"].toString(),
    details: List<String>.from(json["details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
    "price": double.parse(price),
    "details": List<dynamic>.from(details.map((x) => x)),
  };
}
