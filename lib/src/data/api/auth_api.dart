import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';
import 'dart:convert' show utf8;
import 'dart:convert' show base64Url;

class AuthAPI {
  static const String baseUrl = 'https://pravasitax.com/api/authentication';
  static const String bearerToken = 'M6nBvCxAiL9d8eFgHjKmPqRs';
  static const String phpSessionId = '741c37174ca68faa2078dac4b129093a';

  final http.Client _client;

  AuthAPI(this._client) {
    developer.log('AuthAPI initialized with baseUrl: $baseUrl', name: 'AuthAPI');
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $bearerToken',
        'Cookie': 'PHPSESSID=$phpSessionId',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

  Future<bool> sendOTP(String email) async {
    try {
      developer.log('Sending OTP to email: $email', name: 'AuthAPI.sendOTP');

      final body = {
        'email': email,
      };

      // Log request details
      developer.log(
        'Request details:\n'
        'URL: $baseUrl/send-otp\n'
        'Headers: $_headers\n'
        'Body: $body',
        name: 'AuthAPI.sendOTP.request',
      );

      final response = await _client.post(
        Uri.parse('$baseUrl/send-otp'),
        headers: _headers,
        body: body,
      );

      // Log response details
      developer.log(
        'Response details:\n'
        'Status Code: ${response.statusCode}\n'
        'Headers: ${response.headers}\n'
        'Body: ${response.body}',
        name: 'AuthAPI.sendOTP.response',
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['response'] == '200') {
        developer.log('OTP sent successfully', name: 'AuthAPI.sendOTP');
        return true;
      }
      throw Exception(responseData['message'] ?? 'Failed to send OTP');
    } catch (e) {
      developer.log('Failed to send OTP',
          error: e.toString(), name: 'AuthAPI.sendOTP.error');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    try {
      developer.log('Verifying OTP for email: $email', name: 'AuthAPI.verifyOTP');

      final body = {
        'email': email,
        'otp': otp,
      };

      // Log request details
      developer.log(
        'Request details:\n'
        'URL: $baseUrl/verify-otp\n'
        'Headers: $_headers\n'
        'Body: $body',
        name: 'AuthAPI.verifyOTP.request',
      );

      final response = await _client.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers: _headers,
        body: body,
      );

      // Log response details
      developer.log(
        'Response details:\n'
        'Status Code: ${response.statusCode}\n'
        'Headers: ${response.headers}\n'
        'Body: ${response.body}',
        name: 'AuthAPI.verifyOTP.response',
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      
      if (responseData['response'] == '200') {
        // The token is directly in the 'data' field as a string
        final token = responseData['data'] as String;
        
        // Parse the JWT to get user data
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = json.decode(
            utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
          ) as Map<String, dynamic>;
          
          return {
            'token': token,
            'user': payload,  // Contains id, name, email from JWT
          };
        }
        
        return {
          'token': token,
          'user': {},
        };
      }
      
      throw Exception(responseData['message'] ?? 'Invalid OTP');
    } catch (e) {
      developer.log('Failed to verify OTP',
          error: e.toString(), name: 'AuthAPI.verifyOTP.error');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}

final authAPIProvider = Provider<AuthAPI>((ref) {
  developer.log('Creating new AuthAPI instance', name: 'authAPIProvider');
  return AuthAPI(http.Client());
});
