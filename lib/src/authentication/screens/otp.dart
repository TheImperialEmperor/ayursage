import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your main screen widget
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
            onSubmit: (code){if (kDebugMode) {
              print('OTP is => $code');
            }},
          ),
          const SizedBox(height: 20.0,),
          SizedBox(width: double.infinity,
          child: ElevatedButton(onPressed: (){},child: const Text('Next'),),)
        ],
      ),
    ));
  }
}
