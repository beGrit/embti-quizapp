import 'dart:convert';

import 'package:emombti/data/user.dart';
import 'package:emombti/models/core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  Future<User> getUserById(String uid) async {
    final url = Uri.parse('$baseUrl/user/user/$uid');

    try {
      final response = await http.get(url, headers: getHeaders());

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return User.fromJson(body);
      } else if (response.statusCode == 404) {
        throw Exception('User not found (404)');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection failed: $e');
    }
  }

  Future<User> sendVerification(String email) async {
    final url = Uri.parse('$baseUrl/user/send-verification');

    try {
      final String jsonBody = jsonEncode({'email': email});

      final response = await http.post(
        url,
        headers: getHeaders(),
        body: jsonBody, // Pass the JSON here
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return User.fromJson(body);
      } else if (response.statusCode == 404) {
        throw Exception('User not found (404)');
      } else if (response.statusCode == 400) {
        throw Exception('Invalid request: Email is required');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection failed: $e');
    }
  }
}

enum EmailLoginStep { sendVerification, verifyCode }

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._model);

  final UserModel _model;

  User? _user;

  String? errorMessage;
  bool isLoading = false;

  Future<void> emailLogin(
    EmailLoginStep step, {
    String? email,
    String? code,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      switch (step) {
        case EmailLoginStep.sendVerification:
          if (email == null || email.isEmpty) {
            throw Exception('Email is required');
          } else {
            await _model.sendVerification(email);
          }
        case EmailLoginStep.verifyCode:
          if (_user == null || code == null || code.isEmpty) {
            throw Exception(
              'No user found. Please request a verification code first.',
            );
          } else {
            await _verifyCode(_user!.id, code);
          }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _verifyCode(String uid, String code) async {}

  Future<void> clearError() async {
    errorMessage = null;
    notifyListeners();
  }
}
