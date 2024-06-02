import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../../../../../../components/floatingbuttons/invitation_button.dart';
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

  late List<User> usersInformation;

  void updateUserRole(User user) {
    String oldRole = user.roles.first.role;
    String newRole;

    if (oldRole == 'visitante') {
      newRole = 'residente';
    } else if (oldRole == 'residente') {
      newRole = 'visitante';
    } else {
      throw Exception('Invalid role');
    }

    ref
        .read(userInformationProvider.notifier)
        .updateUserRole(user, oldRole, newRole);
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
          content: const Text('¿Estás seguro de que deseas eliminar a este usuario?'),
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
              totalUsers: totalUsers,
              currentUserCount: usersInformation.length,
            ),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
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

    usersInformation = ref
        .watch(userInformationProvider)
        .where((user) => user.roles.any((role) => role.role == 'residente') && user.home == widget.userInformation.home)
        .toList();

    if (kDebugMode) {
      print(usersInformation);
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
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
                  ListView.builder(
                    physics:const  NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: usersInformation.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.0,
                        margin: const EdgeInsets.only(bottom: 30),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          side:
                          const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.badge_outlined,
                                    color: Colors.black,
                                    size: 42,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      usersInformation[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      usersInformation[index].roles.first.role,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDeleteUserDialog(context, usersInformation[index]);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
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
