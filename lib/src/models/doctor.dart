class Doctor {
  final String userType = '0';
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String hospitalName;
  final String qualificationLevel;
  final String registrationNumber;
  final String email;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.hospitalName,
    required this.qualificationLevel,
    required this.registrationNumber,
    required this.email,
  });

  // Optionally, you can add a method to convert this object to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
      'hospitalName': hospitalName,
      'qualificationLevel': qualificationLevel,
      'registrationNumber': registrationNumber,
      'email': email,
    };
  }
}
