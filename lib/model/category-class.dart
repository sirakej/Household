class CategoryClass {
  CategoryClass({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.pluralName,
    this.singularName,
    this.description,
    this.image,
    this.smallerImage,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String pluralName;
  String singularName;
  String description;
  String image;
  String smallerImage;

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pluralName: json["plural_name"],
    singularName: json["singular_name"],
    description: json["description"],
    image: json["image"],
    smallerImage: json["smaller_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plural_name": pluralName,
    "singular_name": singularName,
    "description": description,
    "image": image,
    "smaller_image": smallerImage,
  };
}