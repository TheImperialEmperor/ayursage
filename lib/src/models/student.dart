class Student {
  final String userType = '1';
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String instituteName;
  final String collegeId;
  final String degree;
  final String email;

  Student({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.instituteName,
    required this.collegeId,
    required this.degree,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
      'instituteName': instituteName,
      'collegeId': collegeId,
      'degree': degree,
      'email': email,
    };
  }
}
