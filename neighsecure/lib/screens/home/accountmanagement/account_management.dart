import 'package:flutter/foundation.dart';
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

  @override
  Widget build(BuildContext context) {

    User userInformation = ref
        .watch(userInformationProvider)
        .firstWhere((user) => user.roles.any((role) => role.role == 'visitante'), orElse: () {
      throw Exception('User with role visitante not found');
    });

    bool hasRole(User user, String role) {
      return user.roles.any((userRole) => userRole.role == role);
    }

    List<Permission> permissions = userInformation.permissions;

    if (kDebugMode) {
      print(permissions);
    }
    Widget? maincontent;

    Widget visit = VisitorScreen(userInformation: userInformation, permissions: permissions);

    Widget residentInCharge = ResidentScreen(userInformation: userInformation);

    Widget vigilant = VigilantScreen(userInformation: userInformation);

    if (hasRole(userInformation, 'encargado') || hasRole(userInformation, 'residente')) {
      maincontent = residentInCharge;
    } else if (hasRole(userInformation, 'visitante')) {
      maincontent = visit;
    } else {
      maincontent = vigilant;
    }

    return maincontent;
  }
}
