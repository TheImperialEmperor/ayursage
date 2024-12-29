import 'package:ayursage/src/doctor/screens/doctor_network.dart';
import 'package:ayursage/src/doctor/screens/patient_network.dart';
import 'package:ayursage/src/doctor/screens/profile.dart';
import 'package:flutter/material.dart';

import '../../doctor/screens/doctor_home.dart';
import '../../doctor/screens/show_all_doctors.dart';

class DoctorNavMenu extends StatefulWidget {
  const DoctorNavMenu({super.key});

  @override
  _DoctorNavMenuState createState() => _DoctorNavMenuState();
}

class _DoctorNavMenuState extends State<DoctorNavMenu> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  final List<Widget> _screens = [
    const DoctorHomeScreen(),
    const DoctorListPage(),
    const PatientNetworkScreen(),
    const DoctorProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Keep transparent
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow
              blurRadius: 10,
              offset: const Offset(0, -2), // Shadow above the bar
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            // No background
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            // Handle taps on items
            selectedItemColor: Colors.lightGreen,
            // Selected icon/text color
            unselectedItemColor: Colors.black,
            // Unselected icon/text color
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin_rounded),
                label: "Network",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_rounded),
                label: "Patients",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
