class AdBanner {

  AdBanner({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.image,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String description;
  String image;

  factory AdBanner.fromJson(Map<String, dynamic> json) => AdBanner(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
    "description": description,
    "image": image,
  };

}
