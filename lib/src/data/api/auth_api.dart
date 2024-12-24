import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';
import 'dart:convert' show utf8;
import 'dart:convert' show base64Url;

class AuthAPI {
  static const String baseUrl = 'https://pravasitax.com/api/authentication';
  static const String bearerToken = 'M6nBvCxAiL9d8eFgHjKmPqRs';

  final http.Client _client;

  AuthAPI(this._client) {
    developer.log('AuthAPI initialized with baseUrl: $baseUrl',
        name: 'AuthAPI');
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

  Future<bool> sendOTP(String email) async {
    try {
      developer.log('Initiating OTP send request', name: 'AuthAPI.sendOTP');

      final body = {
        'email': email,
      };

      developer.log(
        'Request details:\n'
        'URL: $baseUrl/send-otp\n'
        'Headers: ${_headers.map((k, v) => MapEntry(k, k == 'Authorization' ? '[REDACTED]' : v))}\n'
        'Body: $body',
        name: 'AuthAPI.sendOTP',
      );

      final response = await _client.post(
        Uri.parse('$baseUrl/send-otp'),
        headers: _headers,
        body: body,
      );

      developer.log(
        'Response received:\n'
        'Status Code: ${response.statusCode}\n'
        'Headers: ${response.headers}\n'
        'Body: ${response.body}',
        name: 'AuthAPI.sendOTP',
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      developer.log(
        'Parsed response data: $responseData',
        name: 'AuthAPI.sendOTP',
      );

      if (responseData['response'] == '200') {
        developer.log('OTP sent successfully', name: 'AuthAPI.sendOTP');
        return true;
      }

      throw Exception(responseData['message'] ?? 'Failed to send OTP');
    } catch (e) {
      developer.log(
        'Error sending OTP',
        error: e.toString(),
        name: 'AuthAPI.sendOTP',
      );
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    try {
      developer.log(
        'Initiating OTP verification for email: $email',
        name: 'AuthAPI.verifyOTP',
      );

      final body = {
        'email': email,
        'otp': otp,
      };

      developer.log(
        'Request details:\n'
        'URL: $baseUrl/verify-otp\n'
        'Headers: ${_headers.map((k, v) => MapEntry(k, k == 'Authorization' ? '[REDACTED]' : v))}\n'
        'Body: $body',
        name: 'AuthAPI.verifyOTP',
      );

      final response = await _client.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers: _headers,
        body: body,
      );

      developer.log(
        'Response received:\n'
        'Status Code: ${response.statusCode}\n'
        'Headers: ${response.headers}\n'
        'Body: ${response.body}',
        name: 'AuthAPI.verifyOTP',
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      developer.log(
        'Parsed response data: $responseData',
        name: 'AuthAPI.verifyOTP',
      );

      if (responseData['response'] == '200') {
        final token = responseData['data'] as String;

        // Log JWT parsing
        developer.log(
          'Parsing JWT token',
          name: 'AuthAPI.verifyOTP',
        );

        final parts = token.split('.');
        Map<String, dynamic> payload = {};

        if (parts.length == 3) {
          final payloadJson =
              utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          payload = json.decode(payloadJson) as Map<String, dynamic>;

          developer.log(
            'JWT payload decoded: $payload',
            name: 'AuthAPI.verifyOTP',
          );
        }

        return {
          'token': token,
          'user': payload,
        };
      }

      throw Exception(responseData['message'] ?? 'Invalid OTP');
    } catch (e) {
      developer.log(
        'Error verifying OTP',
        error: e.toString(),
        name: 'AuthAPI.verifyOTP',
      );
      rethrow;
    }
  }
}

final authAPIProvider = Provider<AuthAPI>((ref) {
  developer.log('Creating new AuthAPI instance', name: 'authAPIProvider');
  return AuthAPI(http.Client());
});
