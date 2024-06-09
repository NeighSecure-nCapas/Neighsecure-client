import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';

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
    if (user.roles.any((userRole) => userRole.role == 'encargado')) {
      return 'encargado';
    } else if (user.roles.any((userRole) => userRole.role == 'residente')) {
      return 'residente';
    } else if (user.roles.any((userRole) => userRole.role == 'visitante')) {
      return 'visitante';
    } else if (user.roles.any((userRole) => userRole.role == 'vigilante')) {
      return 'vigilante';
    } else {
      return 'other';
    }
  }

  @override
  Widget build(BuildContext context) {
    const rol = 'vigilante';

    User userInformation = ref.watch(userInformationProvider).firstWhere(
        (user) => user.roles.any((role) => role.role == rol), orElse: () {
      throw Exception('User with role visitante not found');
    });

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
