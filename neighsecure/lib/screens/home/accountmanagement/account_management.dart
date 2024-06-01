import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {

    //Lets get the user with the specific rol
    var userInformation = ref
        .watch(userInformationProvider)
        .firstWhere((user) => user['role'] == 'visitante', orElse: () => {});

    var entryPasses = userInformation['arrayofpasses'] != null ? userInformation['arrayofpasses'] as List : [];

    if (kDebugMode) {
      print(entryPasses);
    }
    Widget? maincontent;

    Widget visit = VisitorScreen(userInformation: userInformation, entryPasses: entryPasses);

    Widget residentInCharge = ResidentScreen(userInformation: userInformation);

    Widget vigilant = VigilantScreen(userInformation: userInformation);

    switch (userInformation['role']) {
      case 'residente':
      case 'encargado':
        maincontent = residentInCharge;
        break;
      case 'visitante':
        maincontent = visit;
        break;
      default:
        maincontent = vigilant;
    }

    return maincontent;
  }
}
