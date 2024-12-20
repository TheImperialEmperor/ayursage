import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<int?> fetchUserType(String email) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('UserType').doc(email).get();
      if (userDoc.exists && userDoc.data() != null) {
        return userDoc['userType']; // Assuming `userType` is stored as an integer
      }
      return null;
    } catch (e) {
      print("Error fetching userType: $e");
      return null;
    }
  }
}
