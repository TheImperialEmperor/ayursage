import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/controllers/getting_started_controller.dart';

class RegistrationError {
  final String message;
  final bool isCritical;

  RegistrationError(this.message, {this.isCritical = false});
}

extension RegistrationErrorHandling on GettingStartedController {
  void handleRegistrationError(dynamic error) {
    RegistrationError registrationError;

    if (error is Exception) {
      registrationError = RegistrationError(error.toString());
    } else if (error is String) {
      registrationError = RegistrationError(error);
    } else {
      registrationError = RegistrationError('An unexpected error occurred');
    }

    // Log the error (you can replace with your preferred logging mechanism)
    print('Registration Error: ${registrationError.message}');

    // Show error snackbar
    Get.snackbar(
      'Registration Error', 
      registrationError.message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: registrationError.isCritical ? 5 : 3),
    );

    // Optionally, perform additional actions for critical errors
    if (registrationError.isCritical) {
      // Example: Navigate to error screen or reset form
      // Get.offAll(() => ErrorScreen());
    }
  }
}
