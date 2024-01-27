import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your main screen widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('AyurSage'),
      ),
      body: const Center(
        child: Text('Welcome to Your App!'),
      ),
    );
  }
}
