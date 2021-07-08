import 'package:http/http.dart' as http;
import 'candidate-availability.dart';

class CreateCandidate {

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
  String languages;
  String history;
  Availability availability;
  List<http.MultipartFile> image;

  /// Constructor for [CreateCandidate] class
  CreateCandidate();

}