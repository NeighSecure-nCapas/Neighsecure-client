import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../../../../../../components/cards/users_list_card.dart';
import '../../../../../../components/floatingbuttons/invitation_button.dart';
import '../../../../../../models/entities/home.dart';
import '../../../../../../providers/testing_home_information_notifier.dart';
import '../../../../../../providers/testing_user_information_notifier.dart';
import 'invitationscreen/invitation_screen.dart';

class HouseManagement extends ConsumerStatefulWidget {
  const HouseManagement({super.key, required this.userInformation});

  final User userInformation;

  @override
  ConsumerState<HouseManagement> createState() => _HouseManagementState();
}

class _HouseManagementState extends ConsumerState<HouseManagement> {
  final totalUsers = 5;

  Home getHomeInCharge(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .firstWhere((home) => home.encargado == user);
  }

  List<Home> getHomeResident(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .where((home) => home.users.contains(user))
        .toList();
  }

  void updateUserRole(User user) {
    ref.watch(userInformationProvider.notifier).updateUserRole(user.email);
  }

  void showDeleteUserDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Eliminar usuario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: const Text(
              '¿Estás seguro de que deseas eliminar a este usuario?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                updateUserRole(user);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitToInvitation() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            InvitationScreen(
          totalUsers: getHomeInCharge(widget.userInformation).homeNumber,
          userHome: getHomeInCharge(widget.userInformation),
          currentUserCount:
              getHomeInCharge(widget.userInformation).users.length,
          userInformation: widget.userInformation,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersInformation = getHomeInCharge(widget.userInformation).users;

    final allusersInformation = ref.watch(userInformationProvider).toList();

    if (kDebugMode) {
      for (var user in usersInformation) {
        print(
            'Name: ${user.name}, Home ID: ${user.homeId}, Role: ${user.roles.first.role}');
      }
    }

    if (kDebugMode) {
      for (var user in allusersInformation) {
        print(
            'Name: ${user.name}, Home ID: ${user.homeId}, Role: ${user.roles.first.role}');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Mi hogar',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey,
                          size: 32,
                        ),
                        SizedBox(width: 24),
                        Expanded(
                            child: Text(
                          'En el siguiente apartado, puede administrar la lista de integrantes de tu hogar, asi como agregar nuevos.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ))
                      ],
                    )),
                const SizedBox(height: 46),
                Consumer(
                  builder: (context, watch, child) {
                    return UsersList(
                      usersInformation: usersInformation,
                      showDeleteUserDialog: showDeleteUserDialog,
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${usersInformation.length}/$totalUsers restante',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
        floatingActionButton: InvitationButton(
          onSubmit: _submitToInvitation,
        ),
      ),
    );
  }
}
