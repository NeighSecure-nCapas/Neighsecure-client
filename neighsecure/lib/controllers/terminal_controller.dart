import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../repositories/terminal_repository/terminal_repository.dart';

class TerminalController {
  final TerminalRepository repository = TerminalRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();

  Future<void> getTerminals() async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();

    if (token != null) {
      try {
        final response = await client.get(
          Uri.https(dotenv.env['SERVER_URL']!, '/neighSecure/guard/terminal'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (!responseBody.containsKey('data')) {
            throw Exception('Response does not contain terminal data');
          }
          if (kDebugMode) {
            print('Response body: $responseBody');
          }
          await repository.saveTerminals(responseBody['data']);
          isLoading.value = false;
        } else {
          throw Exception('Failed to get terminals');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        isLoading.value = false;
        return;
      }
    } else {
      if (kDebugMode) {
        print('Token is null');
      }
      isLoading.value = false;
      return;
    }
  }

  Future<bool> anonymousEntry(String dateAndHour, String comment,
      String terminalId, String keyId, String role) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();

    if (token != null) {
      try {
        if (kDebugMode) {
          print(dateAndHour);
          print(comment);
          print(terminalId);
          print(keyId);
          print(role);
        }

        final response = await client.post(
          Uri.https(
              dotenv.env['SERVER_URL']!, '/neighSecure/guard/anonymousEntry'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'dateAndHour': dateAndHour,
            'comment': comment,
            'terminalId': terminalId,
            'keyId': keyId,
            'role': role,
          }),
        );

        if (kDebugMode) {
          print(response.statusCode);
        }

        if (response.statusCode == 200) {
          // If the server returns a 200 OK response, parse the JSON.
          if (kDebugMode) {
            print('Anonymous entry registered');
          }
          return true;
        } else {
          if (kDebugMode) {
            print('Failed to register anonymous entry');
          }
          isLoading.value = false;
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        isLoading.value = false;
        return false;
      }
    } else {
      if (kDebugMode) {
        print('Token is null');
      }
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> entry(String dateAndHour, String comment, String terminalId,
      String keyId, String role) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();

    if (token != null) {
      try {
        if (kDebugMode) {
          print(dateAndHour);
          print(comment);
          print(terminalId);
          print(keyId);
          print(role);
        }

        final response = await client.post(
          Uri.https(dotenv.env['SERVER_URL']!, '/neighSecure/guard/entry'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'dateAndHour': dateAndHour,
            'comment': comment,
            'terminalId': terminalId,
            'keyId': keyId,
            'role': role,
          }),
        );

        if (kDebugMode) {
          print(response.statusCode);
        }

        if (response.statusCode == 200) {
          // If the server returns a 200 OK response, parse the JSON.
          if (kDebugMode) {
            print('Entry registered');
          }
          return true;
        } else {
          // Handle different server responses
          if (response.statusCode == 404) {
            if (kDebugMode) {
              print('Terminal or Permission not found');
            }
          } else if (response.statusCode == 400) {
            if (kDebugMode) {
              print(
                  'Key is no longer valid or Permission is no longer valid or Invalid day to enter');
            }
          } else {
            if (kDebugMode) {
              print('Failed to register entry');
            }
          }
          isLoading.value = false;
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        isLoading.value = false;
        return false;
      }
    } else {
      if (kDebugMode) {
        print('Token is null');
      }
      isLoading.value = false;
      return false;
    }
  }
}
