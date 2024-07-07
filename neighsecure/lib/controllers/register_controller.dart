import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neighsecure/repositories/user_repository/user_repository.dart';

import '../models/entities/user.dart';
import '../screens/home/accountmanagement/account_management.dart';

class RegisterController {
  final UserRepository _repository = UserRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();

  Future<void> registerUser(
      BuildContext context, String dui, String phoneNumber) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');
    User? localUser = await _repository.retrieveUserLocally();

    if (localUser == null) {
      isLoading.value = false;
      if (kDebugMode) {
        print('User not found');
      }
      return;
    }

    User user = User(
        id: localUser.id,
        dui: dui,
        phone: phoneNumber,
        roles: localUser.roles,
        email: localUser.email,
        name: localUser.name,
        homeId: '');

    try {
      final response = await client.post(
        Uri.https(
            dotenv.env['SERVER_URL']!, '/neighSecure/visit/completeRegister'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'dui': user.dui,
          'phone': user.phone,
        }),
      );

      if (response.statusCode == 200) {
        await _repository.saveUserLocally(user.toJson());
        isLoading.value = false;

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AccountManagement(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
        return;
      } else if (response.statusCode == 404) {
        isLoading.value = false;
        throw Exception('User or Token not found');
      } else {
        isLoading.value = false;
        throw Exception('Failed to register user');
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      return;
    }
  }
}
