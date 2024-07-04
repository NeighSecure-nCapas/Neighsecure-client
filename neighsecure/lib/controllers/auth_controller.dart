import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neighsecure/repositories/user_repository/user_repository.dart';
import 'package:neighsecure/screens/home/accountmanagement/account_management.dart';
import 'package:neighsecure/screens/introduction/welcome_screen/welcome_screen.dart';

import '../models/entities/auth_model.dart';
import '../models/entities/user.dart';
import '../screens/introduction/user_register/user_register.dart';

class AuthController {
  final AuthModel _model = AuthModel();
  final UserRepository _repository = UserRepository();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final storage = const FlutterSecureStorage();
  String? _authorizationCode;
  String? _accessToken;

  String? get authorizationCode => _authorizationCode;

  Future<void> getAccessTokenResponse(BuildContext context) async {
    try {
      isLoading.value = true;
      final result = await _model.getAccessTokenResponse();

      if (result != null) {
        _accessToken = result.accessToken;
        if (kDebugMode) {
          print('Access token: $_accessToken');
        }
        _processAuthResponse(context, _accessToken!);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      // Aquí puedes manejar la excepción como prefieras
      showAboutDialog(
        context: context,
        applicationName: 'Error',
        children: [
          const Text('Error al establecer la conexión con el servidor')
        ],
        applicationVersion: '1.0.0',
        applicationIcon: const Icon(Icons.error),
      );
    }
  }

  Future<bool?> isUserValid() async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    User? localUser = await _repository.retrieveUserLocally();

    //Print all the user information
    if (kDebugMode) {
      print('Token: $token');
      print('Local user: ${localUser?.dui}');
      print('Local user: ${localUser?.phone}');
      print('Local user: ${localUser?.email}');
      print('Local user: ${localUser?.id}');
      print('Local user: ${localUser?.name}');
      print('Local user: ${localUser?.roles}');
    }

    if (token == null || localUser == null) {
      // If the token or localUser is null, return false.
      isLoading.value = false;
      return false;
    } else if (localUser.dui == null ||
        localUser.dui!.isEmpty ||
        localUser.phone == null ||
        localUser.phone!.isEmpty) {
      // If the 'dui' or 'phone' field is null or empty, return null.
      isLoading.value = false;
      return null;
    } else {
      // If none of the above conditions are met, return true.
      isLoading.value = false;
      return true;
    }
  }

  /*
  void _processAuthResponse(BuildContext context, String? accessToken) async {
    isLoading.value = true;
    if (kDebugMode) {
      print('Before change screen, Access token: $accessToken');
    }
    _isBusy = false;

    if (accessToken != null) {
      var client = http.Client();
      try {
        final response = await client.get(
          Uri.http(
              dotenv.env['SERVER_URL']!,
              '/neighSecure/auth/google/redirect-mobile',
              {'access_token': accessToken}),
        );

        if (kDebugMode) {
          print(response.statusCode);
        }

        var responseBody = jsonDecode(response.body);
        var token = responseBody['data']['token'];

        // Save the token in the secure storage.
        await storage.write(key: 'token', value: token);
        if (response.statusCode == 201 || response.statusCode == 200) {
          await getUserInfo(context, response.statusCode);
          isLoading.value = false;
        } else if (response.statusCode == 500) {
          isLoading.value = false;
          throw Exception('There was an error fetching user info from Google');
        } else {
          isLoading.value = false;
          throw Exception('Failed to authenticate with Google');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred: $e');
        }
        showErrorDialog(
            context, 'B Error al establecer la conexión con el servidor.');
      }
    } else {
      isLoading.value = false;
      showErrorDialog(context, 'C Error al obtener el token de acceso.');
    }
  }

   */

  void _processAuthResponse(BuildContext context, String? accessToken) async {
    isLoading.value = true;
    var client = http.Client();

    if (accessToken != null) {
      try {
        final response = await client.get(
          Uri.http(
              dotenv.env['SERVER_URL']!,
              '/neighSecure/auth/google/redirect-mobile',
              {'access_token': accessToken}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          if (!responseBody.containsKey('data')) {
            throw Exception('Response does not contain user data');
          }
          var token = responseBody['data']['token'];
          if (kDebugMode) {
            print(token);
          }
          await storage.write(key: 'token', value: token);
          await getUserInfo(context, response.statusCode);
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          throw Exception('User not found');
        } else {
          isLoading.value = false;
          throw Exception('Failed to get user info');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred H: $e');
        }
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
    }
  }

  Future<void> getUserInfo(BuildContext context, int statusCode) async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();
    if (token != null) {
      try {
        final response = await client.get(
          Uri.http(dotenv.env['SERVER_URL']!, '/neighSecure/auth/whoami'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (!responseBody.containsKey('data')) {
            throw Exception('Response does not contain user data');
          }

          var user = responseBody['data'];
          if (kDebugMode) {
            print(user);
          }
          await _repository.saveUserLocally(user);
          isLoading.value = false;
          redirectToScreen(context, statusCode);
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          throw Exception('User not found');
        } else {
          isLoading.value = false;
          throw Exception('Failed to get user info');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred H: $e');
        }
        showErrorDialog(
            context, 'H Error al establecer la conexión con el servidor.');
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
      showErrorDialog(
          context, 'Error al establecer la conexión con el servidor.');
    }
  }

  Future<void> fetchUserInfo() async {
    isLoading.value = true;
    final token = await storage.read(key: 'token');
    var client = http.Client();
    if (token != null) {
      try {
        final response = await client.get(
          Uri.http(dotenv.env['SERVER_URL']!, '/neighSecure/auth/whoami'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (!responseBody.containsKey('data')) {
            throw Exception('Response does not contain user data');
          }
          var user = responseBody['data'];
          if (kDebugMode) {
            print(user);
          }
          await _repository.saveUserLocally(user);
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          isLoading.value = false;
          throw Exception('No token provided');
        } else if (response.statusCode == 404) {
          isLoading.value = false;
          throw Exception('User not found');
        } else {
          isLoading.value = false;
          throw Exception('Failed to get user info');
        }
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print('Exception occurred H: $e');
        }
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('Token is null');
      }
    }
  }

  void redirectToScreen(BuildContext context, int statusCode) {
    if (kDebugMode) {
      print('Redirecting to screen');
    }
    if (statusCode == 201) {
      isLoading.value = false;
      // If the user is newly registered, redirect to the user_register screen.
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UserRegister(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else if (statusCode == 200) {
      // If the user exists, redirect to the home screen.
      isLoading.value = false;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AccountManagement(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showAboutDialog(
      context: context,
      applicationName: 'Error',
      children: [Text(message)],
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.error),
    );
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'token');
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
