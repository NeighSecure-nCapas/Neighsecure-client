import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/controllers/auth_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/repositories/user_repository/user_repository.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import 'users_screen/vigilant_screen/vigilant_screen.dart';

class AccountManagement extends ConsumerStatefulWidget {
  const AccountManagement({super.key});

  @override
  ConsumerState<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends ConsumerState<AccountManagement> {
  int? selectPassIndex;

  final UserRepository _repository = UserRepository();

  final AuthController _controller = AuthController();

  User? _user;

  String getRole(User user) {
    List<String?> roles = user.roles!.map((role) => role.role).toList();

    if (roles.contains('Encargado')) {
      return 'Encargado';
    } else if (roles.contains('Residente')) {
      return 'Residente';
    } else if (roles.contains('Visitante')) {
      return 'Visitante';
    } else if (roles.contains('Vigilante')) {
      return 'Vigilante';
    } else {
      return 'Other';
    }
  }

  Future<void> _loadUser() async {
    _user = (await _repository.retrieveUserLocally())!;
  }

  Future<void> _fetchUserInfo() async {
    await _controller.fetchUserInfo();

    _user = (await _repository.retrieveUserLocally())!;

    setState(() {
      _user = _user;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Center(
        child: SplashScreen(),
      );
    } else {
      Widget maincontent;

      Widget visit = VisitorScreen(userInformation: _user!);

      Widget resident = ResidentScreen(userInformation: _user!);

      Widget vigilant = VigilantScreen(userInformation: _user!);

      switch (getRole(_user!)) {
        case 'Residente':
        case 'Encargado':
          maincontent = resident;
          break;
        case 'Visitante':
          maincontent = visit;
          break;
        case 'Vigilante':
          maincontent = vigilant;
          break;
        default:
          maincontent = const Center(
            child: Text('No tiene permisos para acceder a esta sección'),
          );
          break;
      }

      return FutureBuilder(
        future: _loadUser(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SplashScreen(),
            );
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show an error message if _loadUser completed with an error
          } else {
            return maincontent;
          }
        },
      );
    }
  }
}
