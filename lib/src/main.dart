import 'package:ayursage/firebase_options.dart';
import 'package:ayursage/src/profile/getting_started.dart';
import 'package:ayursage/src/repository/auth_repository/authentication_repository.dart';
import 'package:ayursage/src/utils//splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AyurSage',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      //darkTheme: ThemeData(brightness: Brightness.dark),
      //themeMode: ThemeMode.system,
      home: const GettingStartedScreen(),
    );
  }
}