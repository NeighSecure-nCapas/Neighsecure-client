import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neighsecure/repositories/house_repository/house_repository.dart';

class HouseController {
  final HouseRepository repository = HouseRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();

  Future<void> getHomeMembers(String? homeId) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();
    if (token != null) {
      try {
        final response = await client.get(
          Uri.https(dotenv.env['SERVER_URL']!,
              '/neighSecure/homeboss/homeMembers/$homeId'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (!responseBody.containsKey('data')) {
            throw Exception('Response does not contain permissions data');
          }

          var data = responseBody['data'];

          var members = data['homeMembers'];
          var numMembers = data['numberOfMembers'];

          if (kDebugMode) {
            print('Number of members: $numMembers');
            print('Members: $members');
          }

          await repository.saveHomeMembersLocally(members);
          await repository.saveHomeMembersNumber(numMembers);

          isLoading.value = false;
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          throw Exception('Home not found');
        } else {
          isLoading.value = false;
          throw Exception('Failed to load home members');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
    }
  }

  Future<bool> removeMember(String homeId, String userEmail) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();

    if (token != null) {
      try {
        final response = await client.patch(
          Uri.https(
              dotenv.env['SERVER_URL']!, '/neighSecure/homeboss/removeMember'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'homeId': homeId,
            'userEmail': userEmail,
          }),
        );

        var responseBody = jsonDecode(response.body);
        var message = responseBody['message'];

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Response message: $message');
          }
          isLoading.value = false;
          return true;
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          if (kDebugMode) {
            print(message);
          }
          throw Exception('Home or User not found');
        } else {
          isLoading.value = false;
          throw Exception('Failed to remove member');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        return false;
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
      return false;
    }
  }

  Future<bool> addMember(String homeId, String userEmail) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();

    if (token != null) {
      try {
        final response = await client.post(
          Uri.https(
              dotenv.env['SERVER_URL']!, '/neighSecure/homeboss/addMember'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'homeId': homeId,
            'userEmail': userEmail,
          }),
        );

        var responseBody = jsonDecode(response.body);
        var message = responseBody['message'];

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Response message: $message');
          }
          isLoading.value = false;
          return true;
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          if (kDebugMode) {
            print(message);
          }
          throw Exception('Home or User not found');
        } else if (response.statusCode == 400) {
          isLoading.value = false;
          throw Exception('Home is full');
        } else {
          isLoading.value = false;
          throw Exception('Failed to add member');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        return false;
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
      return false;
    }
  }
}
