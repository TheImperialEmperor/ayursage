import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/user_tile.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          final doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return UserTile(
                avatarPlaceholder: 'assets/placeholder.png', // Static placeholder image
                firstName: doctor['firstName'] ?? 'No Name',
                lastName: doctor['lastName'] ?? '',
                description1: doctor['qualificationLevel'] ?? 'No Description1',
                description2: doctor['hospitalName'] ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
