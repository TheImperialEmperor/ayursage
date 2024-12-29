import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialManager {
  static const _emailKey = 'user_email';
  static const _passwordKey = 'user_password';
  
  // Use FlutterSecureStorage for more secure storage
  static final _secureStorage = FlutterSecureStorage();

  // Save credentials securely
  static Future<void> saveCredentials({
    required String email, 
    required String password
  }) async {
    try {
      await _secureStorage.write(key: _emailKey, value: email);
      await _secureStorage.write(key: _passwordKey, value: password);
      
      // Optional: Also save email in SharedPreferences for easier access
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    } catch (e) {
      print('Error saving credentials: $e');
      throw Exception('Failed to save credentials');
    }
  }

  // Retrieve credentials
  static Future<Map<String, String?>> getCredentials() async {
    try {
      String? email = await _secureStorage.read(key: _emailKey);
      String? password = await _secureStorage.read(key: _passwordKey);
      
      return {'email': email, 'password': password};
    } catch (e) {
      print('Error retrieving credentials: $e');
      return {'email': null, 'password': null};
    }
  }

  // Clear credentials (e.g., on logout)
  static Future<void> clearCredentials() async {
    try {
      await _secureStorage.delete(key: _emailKey);
      await _secureStorage.delete(key: _passwordKey);
      
      // Clear email from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
    } catch (e) {
      print('Error clearing credentials: $e');
    }
  }

  // Check if credentials exist
  static Future<bool> hasCredentials() async {
    try {
      String? email = await _secureStorage.read(key: _emailKey);
      return email != null && email.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
