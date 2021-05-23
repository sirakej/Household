
class Candidate {
  Candidate({
    this.createdAt,
    this.updatedAt,
    this.category,
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
    this.availablity,
    this.medical,
    this.clinical,
    this.resedential,
    this.workhistory,
    this.guarantors,
    this.id,
  });

  DateTime createdAt;
  DateTime updatedAt;
  List<String> category;
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
  String availablity;
  String medical;
  String clinical;
  String resedential;
  String workhistory;
  String guarantors;
  String id;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: List<String>.from(json["category"].map((x) => x)),
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
    availablity: json["availablity"],
    medical: json["medical"],
    clinical: json["clinical"],
    resedential: json["resedential"],
    workhistory: json["workhistory"],
    guarantors: json["guarantors"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": List<dynamic>.from(category.map((x) => x)),
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
    "availablity": availablity,
    "medical": medical,
    "clinical": clinical,
    "resedential": resedential,
    "workhistory": workhistory,
    "guarantors": guarantors,
    "_id": id,
  };
}
