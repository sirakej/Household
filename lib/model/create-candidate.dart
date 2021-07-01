class CreateCandidate {

  CreateCandidate({
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.phoneNumber,
    this.origin,
    this.gender,
    this.religion,
    this.tribe,
    this.experience,
    this.residence,
    this.skill,
    this.history,
    this.availability,
    this.category,
    this.profileImage,
    this.medical,
    this.clinical,
    this.resedential,
    this.workhistory,
    this.guarantors,
  });

  String email;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  String origin;
  String gender;
  String religion;
  String tribe;
  int experience;
  String residence;
  String skill;
  String history;
  Availability availability;
  List<String> category;
  String profileImage;
  String medical;
  String clinical;
  String resedential;
  String workhistory;
  String guarantors;

  factory CreateCandidate.fromJson(Map<String, dynamic> json) => CreateCandidate(
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    phoneNumber: json["phone_number"],
    origin: json["origin"],
    gender: json["gender"],
    religion: json["religion"],
    tribe: json["tribe"],
    experience: json["experience"],
    residence: json["residence"],
    skill: json["skill"],
    history: json["history"],
    availability: Availability.fromJson(json["availability"]),
    category: List<String>.from(json["category"].map((x) => x)),
    profileImage: json["profile_image"],
    medical: json["medical"],
    clinical: json["clinical"],
    resedential: json["resedential"],
    workhistory: json["workhistory"],
    guarantors: json["guarantors"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "phone_number": phoneNumber,
    "origin": origin,
    "gender": gender,
    "religion": religion,
    "tribe": tribe,
    "experience": experience,
    "residence": residence,
    "skill": skill,
    "history": history,
    "availability": availability.toJson(),
    "category": List<dynamic>.from(category.map((x) => x)),
    "profile_image": profileImage,
    "medical": medical,
    "clinical": clinical,
    "resedential": resedential,
    "workhistory": workhistory,
    "guarantors": guarantors,
  };
}

class Availability {
  Availability({
    this.title,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  String title;
  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    title: json["title"],
    monday: Day.fromJson(json["monday"]),
    tuesday: Day.fromJson(json["tuesday"]),
    wednesday: Day.fromJson(json["wednesday"]),
    thursday: Day.fromJson(json["thursday"]),
    friday: Day.fromJson(json["friday"]),
    saturday: Day.fromJson(json["saturday"]),
    sunday: Day.fromJson(json["sunday"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "monday": monday.toJson(),
    "tuesday": tuesday.toJson(),
    "wednesday": wednesday.toJson(),
    "thursday": thursday.toJson(),
    "friday": friday.toJson(),
    "saturday": saturday.toJson(),
    "sunday": sunday.toJson(),
  };
}

class Day {
  Day({
    this.availability,
    this.booked,
  });

  bool availability;
  bool booked;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    availability: json["availability"],
    booked: json["booked"],
  );

  Map<String, dynamic> toJson() => {
    "availability": availability,
    "booked": booked,
  };
}
