import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String description1;
  final String description2;
  final String avatarPlaceholder;

  const UserTile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.description1,
    required this.description2,
    required this.avatarPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/gettingStarted/doctor.png'),
        radius: 25,
      ),
      title: Text(
        '$firstName, $lastName',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '$description1, $description2',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    );
  }
}
