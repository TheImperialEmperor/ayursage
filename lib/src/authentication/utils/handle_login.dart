import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/database_repository/firestore_service.dart';
import '../../widgets/bottom_menus/doctor_menu.dart';
import '../../widgets/bottom_menus/patient_menu.dart';
import '../../widgets/bottom_menus/student_menu.dart';


void handleLogin(String email) async {
  try {
    final userType = await FirestoreService.fetchUserType(email);
    if (userType == null) {
      Get.snackbar('Error', 'User type not found. Please contact support.');
      return;
    }

    // Save email and user type to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setInt('user_type', userType);

    // Redirect based on userType
    switch (userType) {
      case 0: // Doctor
        Get.offAll(() => DoctorNavMenu());
        break;
      case 1: // Student
        Get.offAll(() => StudentNavMenu());
        break;
      case 2: // Patient
        Get.offAll(() => PatientNavMenu());
        break;
      default:
        Get.snackbar('Error', 'Invalid user type');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to login: $e');
  }
}
