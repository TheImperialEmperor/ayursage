class Patient {
  final String userType = '2';
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String aadhaarNumber;
  final String bloodGroup;
  final String dateOfBirth;
  final String gender;
  final String email;

  Patient({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.aadhaarNumber,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
      'aadhaarNumber': aadhaarNumber,
      'bloodGroup': bloodGroup,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
    };
  }
}
