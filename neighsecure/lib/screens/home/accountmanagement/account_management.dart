import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';

import '../../../models/entities/permission.dart';
import '../../../providers/testing_user_information_notifier.dart';
import 'users_screen/vigilant_screen/vigilant_screen.dart';

class AccountManagement extends ConsumerStatefulWidget {
  const AccountManagement({super.key});

  @override
  ConsumerState<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends ConsumerState<AccountManagement> {
  int? selectPassIndex;

  String getRole(User user) {
    if (user.roles.any((userRole) =>
        userRole.role == 'encargado' || userRole.role == 'residente')) {
      return 'encargado';
    } else if (user.roles.any((userRole) => userRole.role == 'visitante')) {
      return 'visitante';
    } else {
      return 'other';
    }
  }

  @override
  Widget build(BuildContext context) {
    User userInformation = ref.watch(userInformationProvider).firstWhere(
        (user) => user.roles.any((role) => role.role == 'encargado'),
        orElse: () {
      throw Exception('User with role visitante not found');
    });

    bool hasRole(User user, String role) {
      return user.roles.any((userRole) => userRole.role == role);
    }

    List<Permission> permissions = userInformation.permissions;

    /*
    if (kDebugMode) {
      print(userInformation.toJson());
      print('\n\n');
      for (var permission in permissions) {
        print(permission.toJson());
      }}
     */
    Widget? maincontent;

    Widget visit = VisitorScreen(userInformation: userInformation);

    Widget resident = ResidentScreen(userInformation: userInformation);

    Widget vigilant = VigilantScreen(userInformation: userInformation);

    switch (getRole(userInformation)) {
      case 'residente':
      case 'encargado':
        maincontent = resident;
        break;
      case 'visitante':
        maincontent = visit;
        break;
      case 'vigilante':
        maincontent = vigilant;
        break;
      default:
        maincontent = const Center(
          child: Text('No tiene permisos para acceder a esta sección'),
        );
        break;
    }

    return maincontent;
  }
}
