import 'candidate-availability.dart';
import 'category-class.dart';

class Candidate {

  Candidate({
    this.createdAt,
    this.updatedAt,
    this.category,
    this.email,
    this.description,
    this.firstName,
    this.lastName,
    this.age,
    this.phoneNumber,
    this.origin,
    this.tribe,
    this.gender,
    this.religion,
    this.experience,
    this.residence,
    this.skill,
    this.language,
    this.history,
    this.availability,
    this.medical,
    this.clinical,
    this.resedential,
    this.workhistory,
    this.guarantors,
    this.profileImage,
    this.rating,
    this.officialHeReport,
    this.id,
    this.recommendedCategory,
  });

  DateTime createdAt;
  DateTime updatedAt;
  List<String> category;
  String email;
  String description;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  String origin;
  String tribe;
  String gender;
  String religion;
  int experience;
  String residence;
  String skill;
  String language;
  List<dynamic> history;
  Availability availability;
  String medical;
  String clinical;
  String resedential;
  String workhistory;
  String guarantors;
  String profileImage;
  int rating;
  String officialHeReport;
  String id;
  CategoryClass recommendedCategory;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: List<String>.from(json["category"].map((x) => x)),
    email: json["email"],
    description: json["description"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    phoneNumber: json["phone_number"],
    origin: json["origin"],
    tribe: json["tribe"],
    gender: json["gender"],
    religion: json["religion"] ?? '',
    experience: json["experience"],
    residence: json["residence"],
    skill: json["skill"],
    language: json["language"],
    history:  json["history"],
    availability: Availability.fromJson(json["availability"]),
    medical: json["medical"],
    clinical: json["clinical"],
    resedential: json["resedential"],
    workhistory: json["workhistory"],
    guarantors: json["guarantors"],
    profileImage: json["profile_image"],
    rating: json["rating"],
    officialHeReport: json["official_he_report"],
    id: json["_id"],
    recommendedCategory: json["recommended_category"] == null
        ? null
        : CategoryClass.fromJson(json["recommended_category"]),
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": List<dynamic>.from(category.map((x) => x)),
    "email": email,
    "description": description,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "phone_number": phoneNumber,
    "origin": origin,
    "tribe": tribe,
    "gender": gender,
    "religion": religion,
    "experience": experience,
    "residence": residence,
    "skill": skill,
    "language": language,
    "history": history,
    "availability": availability.toJson(),
    "medical": medical,
    "clinical": clinical,
    "resedential": resedential,
    "workhistory": workhistory,
    "guarantors": guarantors,
    "profile_image": profileImage,
    "rating": rating,
    "official_he_report": officialHeReport,
    "_id": id,
  };
}

