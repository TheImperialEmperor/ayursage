import 'package:ayursage/firebase_options.dart';
import 'package:ayursage/src/authentication/screens/login.dart';
import 'package:ayursage/src/repository/auth_repository/authentication_repository.dart';
import 'package:ayursage/src/repository/database_repository/database_repository.dart';
import 'package:ayursage/src/widgets/bottom_menus/doctor_menu.dart';
import 'package:ayursage/src/widgets/bottom_menus/patient_menu.dart';
import 'package:ayursage/src/widgets/bottom_menus/student_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthenticationRepository());
  Get.put(DatabaseRepository()); // Initialize DatabaseRepository
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    final userType = prefs.getInt('user_type');

    if (email != null && userType != null) {
      switch (userType) {
        case 0:
          return DoctorNavMenu();
        case 1:
          return StudentNavMenu();
        case 2:
          return PatientNavMenu();
        default:
          return const LoginScreen();
      }
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AyurSage',
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: snapshot.data,
        );
      },
    );
  }
}
