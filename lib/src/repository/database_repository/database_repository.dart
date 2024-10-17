import 'dart:ffi';

import 'package:ayursage/src/authentication/screens/login.dart';
import 'package:ayursage/src/home.dart';
import 'package:ayursage/src/models/doctor.dart';
import 'package:ayursage/src/repository/auth_repository/exceptions/signup_email_password_failure.dart';
import 'package:ayursage/src/utils/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/patient.dart';
import '../../models/student.dart';

class DatabaseRepository extends GetxController {
  static DatabaseRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = ''.obs;

  void onRead() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SplashScreen())
        : Get.offAll(() => const HomeScreen());
  }

  uploadDoctorDetails(Doctor doctor) async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.email) // Assuming doctor has an ID field, otherwise use FirebaseAuth User ID
          .set({
        'firstName': doctor.firstName,
        'lastName': doctor.lastName,
        'phoneNumber': doctor.phoneNumber,
        'instituteName': doctor.instituteName,
        'qualificationLevel': doctor.qualificationLevel,
        'registrationNumber': doctor.registrationNumber,
      });
      print("Doctor details uploaded successfully");
    } catch (e) {
      print("Failed to upload doctor details: $e");
    }
  }

  uploadStudentDetails(Student student) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(student.email) // Assuming student has an ID field
          .set({
        'firstName': student.firstName,
        'lastName': student.lastName,
        'phoneNumber': student.phoneNumber,
        'instituteName': student.instituteName,
        'collegeID': student.collegeId,
        'degree': student.degree,
      });
      print("Student details uploaded successfully");
    } catch (e) {
      print("Failed to upload student details: $e");
    }
  }

  uploadPatientDetails(Patient patient) async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(patient.email) // Assuming patient has an ID field
          .set({
        'firstName': patient.firstName,
        'lastName': patient.lastName,
        'phoneNumber': patient.phoneNumber,
        'aadharNumber': patient.aadharNumber,
        'bloodGroup': patient.bloodGroup,
        'dob': patient.dateOfBirth,
        'gender': patient.gender,
      });
      print("Patient details uploaded successfully");
    } catch (e) {
      print("Failed to upload patient details: $e");
    }
  }

}
