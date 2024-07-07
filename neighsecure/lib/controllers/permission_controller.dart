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
        Uri.https(
            dotenv.env['SERVER_URL']!, '/neighSecure/visit/myPermissions'),
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

  Future<void> getAllPermissionsByHome(String? homeId) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.get(
        Uri.https(dotenv.env['SERVER_URL']!,
            '/neighSecure/resident/permissions/home/$homeId'),
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
          print('User homeId: $homeId');
          print('Permissions: $permissionsjson');
        }

        List<Permissions> permissions = permissionsjson
            .map<Permissions>(
                (item) => Permissions.fromJson(item as Map<String, dynamic>))
            .toList();

        await repository.savePermissionsToManage(permissions);
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

  Future<void> getPermission(String permissionId) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.get(
        Uri.https(dotenv.env['SERVER_URL']!,
            '/neighSecure/homeboss/permissions/$permissionId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (!responseBody.containsKey('data')) {
          throw Exception('Response does not contain permission data');
        }

        var permissionjson = responseBody['data'];

        if (kDebugMode) {
          print(permissionjson);
        }

        Permissions permissions = Permissions.fromJson(permissionjson);

        await repository.saveDetails(permissions);
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
        throw Exception('Failed to get permission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to get permission due to an error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createPermission(
    String type,
    String startDate,
    String endDate,
    String startTime,
    String endTime,
    String days,
    String homeId,
    String visitor,
    String grantedBy,
  ) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.post(
        Uri.https(
            dotenv.env['SERVER_URL']!, '/neighSecure/resident/newPermission'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
          'startDate': startDate,
          'endDate': endDate,
          'startTime': startTime,
          'endTime': endTime,
          'days': days,
          'homeId': homeId,
          'visitor': visitor,
          'grantedBy': grantedBy,
        }),
      );

      if (kDebugMode) {
        print(response.statusCode);
      }

      if (response.statusCode == 201) {
        return true;
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
        throw Exception('Failed to create permission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to create permission due to an error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> approvePermission(String permissionId) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.patch(
        Uri.https(dotenv.env['SERVER_URL']!,
            '/neighSecure/homeboss/permissions/approve/$permissionId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return true;
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
        throw Exception('Failed to approve permission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to approve permission due to an error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> rejectPermission(String permissionId) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.patch(
        Uri.https(dotenv.env['SERVER_URL']!,
            '/neighSecure/homeboss/permissions/reject/$permissionId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return true;
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
        throw Exception('Failed to reject permission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to reject permission due to an error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deletePermission(String permissionId) async {
    isLoading.value = true;
    final client = http.Client();
    final token = await storage.read(key: 'token');

    try {
      final response = await client.patch(
        Uri.https(dotenv.env['SERVER_URL']!,
            '/neighSecure/resident/permissions/delete/$permissionId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return true;
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
        throw Exception('Failed to delete permission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      throw Exception('Failed to delete permission due to an error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
