class UserModel {
  String? Name;
  int? Age;
  String? Gender;
  String? Address;
  String? Email;
  int? PhoneNumber;

  UserModel(
      {required this.Name,
      required this.Age,
      required this.Gender,
      required this.Address,
      required this.Email,
      required this.PhoneNumber});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
            Name: json['Name'] as String,
            Age: json['Age'] as int,
            Gender: json['Gender'] as String,
            Address: json['Address'] as String,
            Email: json['Email'] as String,
            PhoneNumber: json['PhoneNumber'] as int);

  UserModel copyWith({
    String? Name,
    int? Age,
    String? Gender,
    String? Address,
    String? Email,
    int? PhoneNumber,
  }) {
    return UserModel(
        Name: Name ?? this.Name,
        Age: Age ?? this.Age,
        Gender: Gender ?? this.Gender,
        Address: Address ?? this.Address,
        Email: Email ?? this.Email,
        PhoneNumber: PhoneNumber ?? this.PhoneNumber);
  }

  Map<String, Object?> toJson() {
    return {
      'Name': Name,
      'Age': Age,
      'Gender': Gender,
      'Address': Address,
      'Email': Email,
      'PhoneNumber': PhoneNumber
    };
  }
}
