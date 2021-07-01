
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
  Map<String, dynamic> monday;
  Map<String, dynamic> tuesday;
  Map<String, dynamic> wednesday;
  Map<String, dynamic> thursday;
  Map<String, dynamic> friday;
  Map<String, dynamic> saturday;
  Map<String, dynamic> sunday;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    title: json["title"],
    monday: json["monday"],
    tuesday: json["tuesday"],
    wednesday: json["wednesday"],
    thursday: json["thursday"],
    friday: json["friday"],
    saturday: json["saturday"],
    sunday: json["sunday"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "saturday": saturday,
    "sunday": sunday,
  };
}