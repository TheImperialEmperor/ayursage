import 'package:ayursage/src/authentication/screens/signup.dart';
import 'package:ayursage/src/home_screens/guest_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../home.dart';
import '../../utils/constants.dart';
import '../../utils/handle_login.dart';
import '../controllers/login_controller.dart';
import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /*final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();*/
  bool isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showOTPScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OTPScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      logo,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'AyurSage',
                      style: TextStyle(
                        fontFamily: 'red_hat',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  'Login to your Account',
                  style: TextStyle(
                    fontFamily: 'red_hat',
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email),
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: controller.password,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Make selection!',
                                  style: TextStyle(
                                    fontFamily: 'red_hat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                const Text(
                                  'Select one of the options given below to reset your password:',
                                  style: TextStyle(
                                    fontFamily: 'red_hat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context); // Close the bottom sheet
                                    _showOTPScreen();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.mail_outline_rounded,
                                          size: 60.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('E-Mail',
                                                style: TextStyle(
                                                  fontFamily: 'red_hat',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                )),
                                            Text(
                                              'Reset via E-Mail Verification.',
                                              style: TextStyle(
                                                fontFamily: 'red_hat',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context); // Close the bottom sheet
                                    _showOTPScreen();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          size: 60.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Phone',
                                                style: TextStyle(
                                                  fontFamily: 'red_hat',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                )),
                                            Text(
                                              'Reset via Phone Verification.',
                                              style: TextStyle(
                                                fontFamily: 'red_hat',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontFamily: 'red_hat',
                          color: Color.fromRGBO(116, 198, 157, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(controller.email.text);
                      LoginController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
                      /*await _saveCredentials(
                      controller.email.text.trim(),
                      controller.password.text.trim(),
                      );*/
                      handleLogin(controller.email.text.trim());
                      /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      );*/
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(116, 198, 157, 1),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Ink(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'red_hat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not registered yet? ',
                      style: TextStyle(
                        fontFamily: 'red_hat',
                        color: Color(0xFF9D9693),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Register here!',
                        style: TextStyle(
                          fontFamily: 'red_hat',
                          color: Color.fromRGBO(116, 198, 157, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  '--OR--',
                  style: TextStyle(
                    fontFamily: 'red_hat',
                    color: Color(0xFF9D9693),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GuestHome()),
                    );
                  },
                  child: const Text(
                    'Login as Guest!',
                    style: TextStyle(
                      fontFamily: 'red_hat',
                      color: Color.fromRGBO(116, 198, 157, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
