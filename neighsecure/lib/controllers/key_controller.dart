import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../repositories/key_repository/key_repository.dart';

class KeyController {
  final KeyRepository repository = KeyRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();

  final KeyRepository _repository = KeyRepository();

  Future<bool> validatePermission(String? permissionId) async {
    isLoading.value = true;
    var client = http.Client();
    final token = await storage.read(key: 'token');

    DateTime now = DateTime.now();

    if (kDebugMode) {
      print(token);
    }

    if (kDebugMode) {
      print(permissionId);
    }

    String generationDate = DateFormat('dd/MM/yyyy').format(now);
    if (kDebugMode) {
      print(generationDate);
    }

    String generationTime = DateFormat('HH:mm').format(now);
    if (kDebugMode) {
      print(generationTime);
    }

    String generationDay = DateFormat('EEEE').format(now);

    generationDay = await translateDay(generationDay);

    if (kDebugMode) {
      print(generationDay);
    }

    try {
      final response = await client.post(
        Uri.https(
            dotenv.env['SERVER_URL']!, '/neighSecure/visit/validatePermission'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'permissionId': permissionId,
          'generationDate': generationDate,
          'generationTime': generationTime,
          'generationDay': generationDay,
        }),
      );

      if (kDebugMode) {
        print(response.statusCode);
      }

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (!responseBody.containsKey('data')) {
          throw Exception('Response does not contain permission data');
        }

        var key = responseBody['data'];

        if (kDebugMode) {
          print('Permission validated');
        }
        await _repository.saveKey(key);
        isLoading.value = false;
        return true;
      } else {
        // Handle different server responses
        if (response.statusCode == 404) {
          if (kDebugMode) {
            print('User or Permission not found');
          }
        } else if (response.statusCode == 400) {
          if (kDebugMode) {
            print('Permission is not valid anymore or not in the right time');
          }
        } else {
          if (kDebugMode) {
            print('Failed to validate permission');
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
  }

  Future<String> translateDay(String day) async {
    switch (day) {
      case 'Monday':
        return 'Lunes';
      case 'Tuesday':
        return 'Martes';
      case 'Wednesday':
        return 'Miercoles';
      case 'Thursday':
        return 'Jueves';
      case 'Friday':
        return 'Viernes';
      case 'Saturday':
        return 'Sabado';
      case 'Sunday':
        return 'Domingo';
      default:
        return 'Día no reconocido';
    }
  }
}
