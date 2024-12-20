import 'package:ayursage/firebase_options.dart';
import 'package:ayursage/src/authentication/screens/login.dart';
import 'package:ayursage/src/repository/auth_repository/authentication_repository.dart';
import 'package:ayursage/src/repository/database_repository/database_repository.dart'; // Import DatabaseRepository
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
    Get.put(AuthenticationRepository());
    Get.put(DatabaseRepository()); // Initialize DatabaseRepository
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AyurSage',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}