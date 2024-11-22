import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import '../api/auth_api.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String? token;
  final Map<String, dynamic>? userData;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.token,
    this.userData,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    String? token,
    Map<String, dynamic>? userData,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      token: token ?? this.token,
      userData: userData ?? this.userData,
    );
  }

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, isLoading: $isLoading, error: $error, token: $token, userData: $userData)';
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthAPI _authAPI;

  AuthNotifier(this._authAPI) : super(AuthState()) {
    developer.log('AuthNotifier initialized', name: 'AuthNotifier');
  }

  Future<void> sendOTP(String email) async {
    developer.log('Attempting to send OTP to: $email',
        name: 'AuthNotifier.sendOTP');
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _authAPI.sendOTP(email);
      if (success) {
        state = state.copyWith(isLoading: false);
        developer.log('OTP sent successfully', name: 'AuthNotifier.sendOTP');
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      developer.log('Failed to send OTP',
          error: errorMessage, name: 'AuthNotifier.sendOTP');
      state = state.copyWith(isLoading: false, error: errorMessage);
    }

    developer.log('New state after sendOTP: $state',
        name: 'AuthNotifier.sendOTP');
  }

  Future<void> verifyOTP(String email, String otp) async {
    developer.log('Attempting to verify OTP for: $email',
        name: 'AuthNotifier.verifyOTP');
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authAPI.verifyOTP(email, otp);
      
      // Now we know response will have the correct structure
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        token: response['token'] as String,
        userData: response['user'] as Map<String, dynamic>,
      );
      
      developer.log(
        'OTP verified successfully. User authenticated.\n'
        'Token: ${response['token']}\n'
        'User Data: ${response['user']}',
        name: 'AuthNotifier.verifyOTP'
      );
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      developer.log('Failed to verify OTP',
          error: errorMessage, name: 'AuthNotifier.verifyOTP');
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: errorMessage,
        token: null,
        userData: null,
      );
    }

    developer.log('New state after verifyOTP: $state',
        name: 'AuthNotifier.verifyOTP');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  developer.log('Creating new AuthNotifier instance', name: 'authProvider');
  return AuthNotifier(ref.watch(authAPIProvider));
});
