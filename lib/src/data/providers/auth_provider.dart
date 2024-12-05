import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/secure_storage_service.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? error;

  AuthState({
    this.isAuthenticated = false,
    this.token,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _initializeAuthState();
  }

  Future<void> _initializeAuthState() async {
    final token = await SecureStorageService.getAuthToken();
    final isLoggedIn = await SecureStorageService.isLoggedIn();

    if (token != null && isLoggedIn) {
      state = state.copyWith(
        isAuthenticated: true,
        token: token,
      );
    }
  }

  Future<void> sendOTP(String email) async {
    try {
      // TODO: Replace with your actual API call
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      // If the API call is successful, you might want to store the email temporarily
      // await SecureStorageService.saveEmail(email);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<void> verifyOTP(String email, String otp) async {
    try {
      // TODO: Replace with your actual API call
      await Future.delayed(Duration(seconds: 2)); // Simulating API call

      // Simulate successful verification
      final token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';

      // Save credentials securely
      await SecureStorageService.saveAuthToken(token);

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    await SecureStorageService.clearCredentials();
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
