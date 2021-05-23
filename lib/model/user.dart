/// A class to hold my [User] model
class User {
  /// This variable holds the user token
  String _token;

  /// This variable holds the user id
  String _id;

  /// This variable holds the user created at
  DateTime _createdAt;

  /// This variable holds the user updated at
  DateTime _updatedAt;

  /// This variable holds the user first name
  String _firstName;

  /// This variable holds the user last name
  String _surName;

  /// This variable holds the user email address
  String _email;

  /// This variable holds the user phone number
  String _phoneNumber;

  // _profileImage;

  /// Setting constructor for [User] class
  User(this._token,
      this._id,
      this._createdAt,
      this._updatedAt,
      this._firstName,
      this._surName,
      this._email,
      this._phoneNumber,
    //  this._profileImage
      );

  /// Creating getters for my [_token] value
  String get token => _token;

  /// Creating getters for my [_id] value
  String get id => _id;

  /// Creating getters for my [_createdAt] value
  DateTime get createdAt => _createdAt;

  /// Creating getters for my [_updatedAt] value
  DateTime get updatedAt => _updatedAt;

  /// Creating getters for my [_firstName] value
  String get firstName => _firstName;

  /// Creating getters for my [_surName] value
  String get surName => _surName;

  /// Creating getters for my [_email] value
  String get email => _email;

  /// Creating getters for my [_phoneNumber] value
  String get phoneNumber => _phoneNumber;

 // String get profileImage => _profileImage;

  /// Function to map user's details from a JSON object
  User.map(dynamic obj) {
    this._token = obj["token"];
    this._id = obj["_id"];
    this._createdAt = DateTime.parse(obj["created_at"]);
    this._updatedAt = DateTime.parse(obj["updated_at"]);
    this._firstName = obj["first_name"];
    this._surName = obj["surname"];
    this._email = obj["email"];
    this._phoneNumber = obj["phone_number"];
    //this._profileImage = obj["profile_image"];
  }

  /// Function to map user's details to a JSON object
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["token"] = _token;
    map["id"] = _id;
    map["created_at"] = _createdAt.toString();
    map["updated_at"] = _updatedAt.toString();
    map["first_name"] = _firstName;
    map["surname"] = _surName;
    map["email"] = _email;
    map["phone_number"] = _phoneNumber;
   // map["profile_image"] = _profileImage;
    return map;
  }

}
