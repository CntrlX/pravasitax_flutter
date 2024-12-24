import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class ForumAPI {
  static const String baseUrl = 'https://pravasitax.com/api';
  static const String bearerToken = 'M6nBvCxAiL9d8eFgHjKmPqRs';

  final http.Client _client;

  ForumAPI(this._client);

  Map<String, String> _getHeaders(String userToken) => {
        'Authorization': 'Bearer $bearerToken',
        'User-Token': userToken,
        'Content-Type': 'application/json',
      };

  Future<List<Map<String, dynamic>>> getCategories(String userToken) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/categories/get');

      final response = await _client.get(uri, headers: _getHeaders(userToken));

      developer.log('Get categories response: ${response.body}',
          name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
        throw Exception(responseData['message'] ?? 'Failed to get categories');
      }
      throw Exception('Failed to get categories: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error getting categories',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to get categories: $e');
    }
  }

  Future<Map<String, dynamic>> createThread(
    String userToken, {
    required String title,
    required String description,
    required String categoryId,
    http.MultipartFile? postImage,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/threads/create');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(_getHeaders(userToken))
        ..fields['title'] = title
        ..fields['description'] = description
        ..fields['category_id'] = categoryId;

      if (postImage != null) {
        request.files.add(postImage);
      }

      final response = await http.Response.fromStream(await request.send());

      developer.log('Create thread response: ${response.body}',
          name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return responseData['data'];
        }
        throw Exception(responseData['message'] ?? 'Failed to create thread');
      }
      throw Exception('Failed to create thread: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error creating thread',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to create thread: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getThreads(
      String userToken, String categoryId) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/threads/get').replace(
        queryParameters: {'category_id': categoryId},
      );

      final response = await _client.get(uri, headers: _getHeaders(userToken));

      developer.log('Get threads response: ${response.body}', name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
        throw Exception(responseData['message'] ?? 'Failed to get threads');
      }
      throw Exception('Failed to get threads: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error getting threads',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to get threads: $e');
    }
  }

  Future<void> markThreadAsClosed(String userToken, String threadId) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/threads/mark-as-closed');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(_getHeaders(userToken))
        ..fields['thread_id'] = threadId;

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to mark thread as closed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      if (responseData['response'] != '200') {
        throw Exception(
            responseData['message'] ?? 'Failed to mark thread as closed');
      }
    } catch (e, stack) {
      developer.log(
        'Error marking thread as closed',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to mark thread as closed: $e');
    }
  }

  Future<Map<String, dynamic>> createPost(
    String userToken, {
    required String threadId,
    required String content,
    String? parentPostId,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/posts/create');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(_getHeaders(userToken))
        ..fields['thread_id'] = threadId
        ..fields['post_content'] = content;

      if (parentPostId != null) {
        request.fields['parent_post_id'] = parentPostId;
      }

      final response = await http.Response.fromStream(await request.send());

      developer.log('Create post response: ${response.body}', name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return responseData['data'];
        }
        throw Exception(responseData['message'] ?? 'Failed to create post');
      }
      throw Exception('Failed to create post: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error creating post',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to create post: $e');
    }
  }

  Future<void> markThreadAsDeleted(String userToken, String threadId) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/threads/mark-as-closed');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(_getHeaders(userToken))
        ..fields['thread_id'] = threadId;

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to mark thread as deleted: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      if (responseData['response'] != '200') {
        throw Exception(
            responseData['message'] ?? 'Failed to mark thread as deleted');
      }
    } catch (e, stack) {
      developer.log(
        'Error marking thread as deleted',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to mark thread as deleted: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPosts(
      String userToken, String threadId) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/posts/get').replace(
        queryParameters: {'thread_id': threadId},
      );

      final response = await _client.get(uri, headers: _getHeaders(userToken));

      developer.log('Get posts response: ${response.body}', name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
        throw Exception(responseData['message'] ?? 'Failed to get posts');
      }
      throw Exception('Failed to get posts: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error getting posts',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getReplies(
    String userToken,
    String threadId,
    String parentPostId,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/forum/posts/getReplies').replace(
        queryParameters: {
          'thread_id': threadId,
          'parent_post_id': parentPostId,
        },
      );

      final response = await _client.get(uri, headers: _getHeaders(userToken));

      developer.log('Get replies response: ${response.body}', name: 'ForumAPI');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['response'] == '200') {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
        throw Exception(responseData['message'] ?? 'Failed to get replies');
      }
      throw Exception('Failed to get replies: ${response.statusCode}');
    } catch (e, stack) {
      developer.log(
        'Error getting replies',
        error: e,
        stackTrace: stack,
        name: 'ForumAPI',
      );
      throw Exception('Failed to get replies: $e');
    }
  }
}

final forumAPIProvider = Provider<ForumAPI>((ref) {
  return ForumAPI(http.Client());
});
