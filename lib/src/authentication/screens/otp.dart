import 'package:ayursage/src/authentication/controllers/otp_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your main screen widget
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'CO\nDE',
            style: TextStyle(
              fontFamily: 'red_hat',
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          const Text(
            'VERIFICATION',
            style: TextStyle(
              fontFamily: 'red_hat',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 40.0),
          const Text(
            'Enter the verification code sent at ',
            textAlign: TextAlign.center,
          ),
          OtpTextField(
            mainAxisAlignment: MainAxisAlignment.center,
            numberOfFields: 6,
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            keyboardType: TextInputType.number,
            onSubmit: (code) {
              if (kDebugMode) {
                otp = code;
                OTPController.instance.verifyOTP(otp);
              }
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                OTPController.instance.verifyOTP(otp);
              },
              child: const Text('Next'),
            ),
          )
        ],
      ),
    ));
  }
}
