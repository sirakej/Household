class CategoryClass {
  CategoryClass({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.image,
    this.smallerImage,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;
  String image;
  String smallerImage;

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    description: json["description"],
    image: json["image"],
    smallerImage: json["smaller_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "description": description,
    "image": image,
    "smaller_image": smallerImage,
  };
}