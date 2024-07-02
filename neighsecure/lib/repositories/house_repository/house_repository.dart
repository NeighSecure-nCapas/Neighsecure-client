import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/user.dart';

class HouseRepository {
  Future<void> saveHomeMembersLocally(List<dynamic> membersJson) async {
    List<User> members = [];

    for (var userJson in membersJson) {
      // Check if all required fields are present and not null
      if (userJson['userId'] == null ||
          userJson['name'] == null ||
          userJson['email'] == null ||
          userJson['phone'] == null ||
          userJson['roles'] == null ||
          userJson['dui'] == null ||
          userJson['homeId'] == null ||
          userJson['homeNumber'] == null) {
        if (kDebugMode) {
          print('Error: User data is missing required fields.');
          print(userJson);
        }
      }

      // Convert null fields to empty strings
      userJson['userId'] = userJson['userId'] ?? '';
      userJson['name'] = userJson['name'] ?? '';
      userJson['email'] = userJson['email'] ?? '';
      userJson['phone'] = userJson['phone'] ?? '';
      userJson['dui'] = userJson['dui'] ?? '';
      userJson['homeId'] = userJson['homeId'] ?? '';
      userJson['homeNumber'] = userJson['homeNumber'] ?? '';

      // Convert the JSON object to a User object
      User user = User.fromJson(userJson);
      members.add(user);
    }

    if (kDebugMode) {
      print('Members saved locally');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the User object back to a JSON string and save it to SharedPreferences
    await prefs.setString(
        'members', jsonEncode(members.map((m) => m.toJson()).toList()));
  }

  Future<List<User>> retrieveHomeMembersLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? membersString = prefs.getString('members');
    List<User> members = [];

    if (membersString != null) {
      List<dynamic> membersJson = jsonDecode(membersString);
      members = membersJson
          .map<User>((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return members;
  }

  Future<void> saveHomeMembersNumber(int number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('membersNumber', number);
  }

  Future<int> retrieveHomeMembersNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? number = prefs.getInt('membersNumber');
    return number ?? 0;
  }
}
