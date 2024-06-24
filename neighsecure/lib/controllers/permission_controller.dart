import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neighsecure/repositories/permission_repository/permission_repository.dart';

import '../models/entities/permissions.dart';

class PermissionController {
  final PermissionRepository repository = PermissionRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();

  Future<void> getMyPermissions() async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.get(
        Uri.http(dotenv.env['SERVER_URL']!, '/neighSecure/visit/myPermissions'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (!responseBody.containsKey('data')) {
          throw Exception('Response does not contain permissions data');
        }

        var permissionsjson = responseBody['data'];

        if (kDebugMode) {
          print(permissionsjson);
        }

        List<Permissions> permissions = permissionsjson
            .map<Permissions>(
                (item) => Permissions.fromJson(item as Map<String, dynamic>))
            .toList();

        await repository.savePermissions(permissions);
        isLoading.value = false;
      } else if (response.statusCode == 400) {
        throw Exception(
            'Bad Request: The server could not understand the request due to invalid syntax.');
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: The client must authenticate itself to get the requested response.');
      } else if (response.statusCode == 403) {
        throw Exception(
            'Forbidden: The client does not have access rights to the content.');
      } else if (response.statusCode == 404) {
        throw Exception(
            'Not Found: The server can not find the requested resource.');
      } else {
        throw Exception('Failed to load permissions');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to load permissions due to an error: $e');
    }
  }
}
