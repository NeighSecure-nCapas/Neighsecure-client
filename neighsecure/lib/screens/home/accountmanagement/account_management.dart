import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/resident_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/visitor_screen/visitor_screen.dart';

import 'users_screen/vigilant_screen/vigilant_screen.dart';

class AccountManagement extends ConsumerStatefulWidget {
  const AccountManagement({super.key});
  @override
  ConsumerState<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends ConsumerState<AccountManagement> {
  var userInformation = {
    'name': 'John Doe',
    'email': 'johndave@gmail.com',
    'phone': '12345678',
    'role': 'encargado',
    'permisos': 'true',
    'arrayofpasses': [
      {
        'typeofVisit': 'unica',
        'state': 'vigente',
        'date': '2024-04-25 10:00 am',
      },
      {
        'typeofVisit': 'multiple',
        'state': 'vigente',
        'dias': 'Lunes - Martes - Viernes',
        'range': '10:00am - 16:00pm',
      },
    ],
    //'role': 'residente',
    //'role': 'visitante',
    //'role': 'vigitante',
  };

  int? selectPassIndex;

  @override
  Widget build(BuildContext context) {

    var entryPasses = userInformation['arrayofpasses'] as List ?? [];

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
