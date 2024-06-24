import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/user.dart';

class UserRepository {
  Future<void> saveUserLocally(Map<String, dynamic> userJson) async {
    // Check if all required fields are present and not null
    if (userJson['userId'] == null ||
        userJson['username'] == null ||
        userJson['email'] == null ||
        userJson['phoneNumber'] == null ||
        userJson['roles'] == null ||
        userJson['dui'] == null ||
        userJson['homeId'] == null) {
      if (kDebugMode) {
        print('Error: User data is missing required fields.');
        print(userJson);
      }
    }

    // Convert null fields to empty strings
    userJson['userId'] = userJson['userId'] ?? '';
    userJson['username'] = userJson['username'] ?? '';
    userJson['email'] = userJson['email'] ?? '';
    userJson['phoneNumber'] = userJson['phoneNumber'] ?? '';
    userJson['dui'] = userJson['dui'] ?? '';
    userJson['homeId'] = userJson['homeId'] ?? '';

    // Convert the JSON object to a User object
    User user = User.fromJson(userJson);

    if (kDebugMode) {
      print(user.toJson());
      print('User saved locally');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the User object back to a JSON string and save it to SharedPreferences
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> updateUserLocally(Map<String, dynamic> userJson) async {
    User user = User.fromJson(userJson);
    String userString = jsonEncode(user.toJson());
    //Show all user information
    if (kDebugMode) {
      print(userString);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userString);
  }

  Future<User?> retrieveUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');

    if (userString != null) {
      Map<String, dynamic> userJson = jsonDecode(userString);
      User user = User.fromJson(userJson);
      return user;
    } else {
      return null;
    }
  }

  Future<void> deleteUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
