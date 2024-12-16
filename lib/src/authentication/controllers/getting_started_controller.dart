import 'package:ayursage/src/models/doctor.dart';  // Import the respective models
import 'package:ayursage/src/models/student.dart';
import 'package:ayursage/src/models/patient.dart';
import 'package:ayursage/src/repository/auth_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/database_repository/database_repository.dart';

class GettingStartedController extends GetxController {
  static GettingStartedController get instance => Get.find();

  RxInt userType = (-1).obs; // Tracks user type selection (0: Doctor, 1: Student, 2: Patient)
  RxString selectedGroup = ''.obs;

  void updateSelectedGroup(String group) {
    selectedGroup.value = group;
    print("Selected group updated to: $group");
  }

  // Common fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  // Doctor-specific fields
  final instituteNameController = TextEditingController();
  final qualificationLevelController = TextEditingController();
  final registrationNumberController = TextEditingController();

  // Student-specific fields
  final collegeIdController = TextEditingController();
  final degreeController = TextEditingController();

  // Patient-specific fields
  final aadharNumberController = TextEditingController();
  final bloodGroupController = TextEditingController(); // Dropdown value
  final dateOfBirthController = TextEditingController(); // Date picker value
  final genderController = TextEditingController(); // Dropdown value

  // Fetch credentials from SharedPreferences
  Future<Map<String, String?>> _getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    return {'email': email, 'password': password};
  }

  // Method to upload based on the user type
  void uploadDetailsToFirebase(value) async {
    try {
      if (userType.value == -1) {
        Get.snackbar('Error', 'Please select a user type');
        return;
      }

      Get.snackbar('Processing', 'Uploading details...');
      await uploadDetailsBasedOnType(value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload details: $e');
    }
  }

  Future<void> uploadDetailsBasedOnType(int value) async {
    switch (value) {
      case 0: // Doctor
        await _uploadDoctorDetails();
        break;
      case 1: // Student
        await _uploadStudentDetails();
        break;
      case 2: // Patient
        await _uploadPatientDetails();
        break;
      default:
        throw Exception('Invalid user type');
    }
  }


  // Upload doctor details using Doctor model
  Future<void> _uploadDoctorDetails() async {
    try {
      final credentials = await _getCredentials();
      final email = credentials['email'];

      if (email == null || email.isEmpty) {
        throw Exception('Email not found');
      }

      // Create a Doctor object
      final doctor = Doctor(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        instituteName: instituteNameController.text.trim(),
        qualificationLevel: qualificationLevelController.text.trim(),
        registrationNumber: registrationNumberController.text.trim(),
        email: email,
      );
      // Upload doctor details using the repository
      await DatabaseRepository.instance.uploadDoctorDetails(doctor);

      Get.snackbar('Success', 'Doctor details uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload doctor details: $e');
    }
  }

  // Upload student details using Student model
  Future<void> _uploadStudentDetails() async {
    try {
      final credentials = await _getCredentials();
      final email = credentials['email'];

      if (email == null || email.isEmpty) {
        throw Exception('Email not found');
      }

      // Create a Student object
      final student = Student(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        instituteName: instituteNameController.text.trim(),
        collegeId: collegeIdController.text.trim(),
        degree: degreeController.text.trim(),
        email: email,
      );

      // Upload student details using the repository
      await DatabaseRepository.instance.uploadStudentDetails(student);

      Get.snackbar('Success', 'Student details uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload student details: $e');
    }
  }

  // Upload patient details using Patient model
  Future<void> _uploadPatientDetails() async {
    try {
      final credentials = await _getCredentials();
      final email = credentials['email'];

      if (email == null || email.isEmpty) {
        throw Exception('Email not found');
      }

      // Create a Patient object
      final patient = Patient(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        aadharNumber: aadharNumberController.text.trim(),
        bloodGroup: bloodGroupController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
        gender: genderController.text.trim(),
        email: email,
      );

      // Upload patient details using the repository
      await DatabaseRepository.instance.uploadPatientDetails(patient);

      Get.snackbar('Success', 'Patient details uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload patient details: $e');
    }
  }

  // Dispose controllers when the screen is closed
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    instituteNameController.dispose();
    qualificationLevelController.dispose();
    registrationNumberController.dispose();
    collegeIdController.dispose();
    degreeController.dispose();
    aadharNumberController.dispose();
    bloodGroupController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    super.dispose();
  }
}