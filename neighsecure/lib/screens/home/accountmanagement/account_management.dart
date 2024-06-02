import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';

import '../../../models/dummy/home_dummy_data.dart';
import '../../../models/dummy/permission_dummy_data.dart';
import '../../../models/dummy/role_dummy_data.dart';
import '../../../models/dummy/token_dummy_data.dart';
import '../../../models/entities/permission.dart';
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

    User userInformation = User(
        id: '1',
        name: 'Dummy User 1',
        email: 'dummy1@email.com',
        phone: '1234567890',
        roles: [
          dummyRoles[0],
          dummyRoles[1],
        ],
        dui: 'dummy-dui-1',
        isActive: true,
        permissions: [
          dummyPermissions[0],
        ],
        tokens: [
          dummyTokens[0],
        ],
        home: dummyHomes[0],
        entries: {
          '2024-04-25 10:00 am',
          '2024-04-25 11:00 am',
          '2024-04-25 12:00 pm',
          '2024-04-25 13:00 pm',
          '2024-04-25 14:00 pm',
          '2024-04-25 15:00 pm',
          '2024-04-25 16:00 pm',
          '2024-04-25 17:00 pm',
          '2024-04-25 18:00 pm',
        }.toList()// Add dummy Token objects as needed
    );

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
