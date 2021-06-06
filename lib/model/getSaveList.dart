class GetSaveList {
  GetSaveList({
    this.candidate,
    this.user,
    this.category,
  });

  List<Candidate> candidate;
  String user;
  Category category;

  factory GetSaveList.fromJson(Map<String, dynamic> json) => GetSaveList(
    candidate: List<Candidate>.from(json["candidate"].map((x) => Candidate.fromJson(x))),
    user: json["user"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "candidate": List<dynamic>.from(candidate.map((x) => x.toJson())),
    "user": user,
    "category": category.toJson(),
  };
}

class Candidate {
  Candidate({
    this.createdAt,
    this.updatedAt,
    this.category,
    this.getCategory,
    this.firstName,
    this.lastName,
    this.age,
    this.phoneNumber,
    this.origin,
    this.gender,
    this.experience,
    this.residence,
    this.skill,
    this.history,
    this.availability,
    this.medical,
    this.clinical,
    this.resedential,
    this.workhistory,
    this.guarantors,
    this.profileImage,
    this.id,
  });

  DateTime createdAt;
  DateTime updatedAt;
  List<String> category;
  List<Category> getCategory;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  String origin;
  String gender;
  int experience;
  String residence;
  String skill;
  String history;
  String availability;
  String medical;
  String clinical;
  String resedential;
  String workhistory;
  String guarantors;
  String profileImage;
  String id;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: List<String>.from(json["category"].map((x) => x)),
    getCategory: List<Category>.from(json["get_category"].map((x) => Category.fromJson(x))),
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    phoneNumber: json["phone_number"],
    origin: json["origin"],
    gender: json["gender"],
    experience: json["experience"],
    residence: json["residence"],
    skill: json["skill"],
    history: json["history"],
    availability: json["availability"],
    medical: json["medical"],
    clinical: json["clinical"],
    resedential: json["resedential"],
    workhistory: json["workhistory"],
    guarantors: json["guarantors"],
    profileImage: json["profile_image"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": List<dynamic>.from(category.map((x) => x)),
    "get_category": List<dynamic>.from(getCategory.map((x) => x.toJson())),
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "phone_number": phoneNumber,
    "origin": origin,
    "gender": gender,
    "experience": experience,
    "residence": residence,
    "skill": skill,
    "history": history,
    "availability": availability,
    "medical": medical,
    "clinical": clinical,
    "resedential": resedential,
    "workhistory": workhistory,
    "guarantors": guarantors,
    "profile_image": profileImage,
    "_id": id,
  };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
