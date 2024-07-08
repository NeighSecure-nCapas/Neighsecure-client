import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/auth_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/repositories/user_repository/user_repository.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import '../../../components/erroscomponetes/error_container.dart';
import 'users_screen/vigilant_screen/vigilant_screen.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({super.key});

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  int? selectPassIndex;

  final UserRepository _repository = UserRepository();
  final AuthController _controller = AuthController();

  Future<User?>? _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserInfo();
  }

  Future<User?> _fetchUserInfo() async {
    await _controller.fetchUserInfo();
    return _repository.retrieveUserLocally();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SplashScreen(),
          );
        } else if (snapshot.hasError) {
          return ErrorRetryWidget(
            onRetry: () {
              setState(() {});
            },
          );
        } else if (snapshot.data == null) {
          return ErrorRetryWidget(
            onRetry: () {
              setState(() {});
            },
          );
        } else {
          return SafeArea(child: _buildMainContent(snapshot.data!));
        }
      },
    );
  }

  Widget _buildMainContent(User user) {
    switch (getRole(user)) {
      case 'Residente':
      case 'Encargado':
        return ResidentScreen(userInformation: user);
      case 'Vigilante':
        return VigilantScreen(userInformation: user);
      case 'Visitante':
        return VisitorScreen(userInformation: user);
      default:
        return const Center(
          child: Text('No tiene permisos para acceder a esta sección'),
        );
    }
  }

  String getRole(User user) {
    List<String?> roles = user.roles!.map((role) => role.role).toList();

    if (roles.contains('Encargado')) {
      return 'Encargado';
    } else if (roles.contains('Residente')) {
      return 'Residente';
    } else if (roles.contains('Vigilante')) {
      return 'Vigilante';
    } else if (roles.contains('Visitante')) {
      return 'Visitante';
    } else {
      return 'Other';
    }
  }
}
