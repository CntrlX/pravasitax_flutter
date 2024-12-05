import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  static const String _tokenKey = 'auth_token';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save auth token
  static Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _isLoggedInKey, value: 'true');
    } catch (e) {
      print('Error saving auth token: $e');
      rethrow;
    }
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      print('Error getting auth token: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final value = await _storage.read(key: _isLoggedInKey);
      return value == 'true';
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Clear stored credentials
  static Future<void> clearCredentials() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _isLoggedInKey);
    } catch (e) {
      print('Error clearing credentials: $e');
      rethrow;
    }
  }
}
