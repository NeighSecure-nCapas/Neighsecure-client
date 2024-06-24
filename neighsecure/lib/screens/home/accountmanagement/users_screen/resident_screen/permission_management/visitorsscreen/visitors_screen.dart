import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/permission.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/providers/dummyProviders/testnameprovider.dart';

import '../../../../../../../providers/dummyProviders/testing_permission_information_notifier.dart';
import 'visitors_state_screen/visitors_details_screen/visitors_details_screen.dart';

class VisitorsScreen extends ConsumerStatefulWidget {
  VisitorsScreen({
    super.key,
    required this.userInformation,
    required this.usersInformation,
    required this.isRedeem,
    this.displayeElements,
    this.onUserRemove,
  });

  late int? displayeElements;

  final User userInformation;

  final List<Permission> usersInformation;

  final Function(Permission)? onUserRemove;

  bool isRedeem;

  @override
  ConsumerState<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends ConsumerState<VisitorsScreen> {
  var defaultDisplayElements = 3;

  List<User> filtereduserInformation = [];

  /*
  List<User> filterUserInformatio(String name) {
    final filtereduserInformation = widget.isRedeem
        ? widget.usersInformation
            .where((item) =>
                item.permissions
                    .any((permission) => permission.status == true) &&
                item.roles.any((role) => role.role == 'visitante'))
            .toList()
        : widget.usersInformation
            .where((item) =>
                item.permissions
                    .any((permission) => permission.status == false) &&
                item.roles.any((role) => role.role == 'visitante'))
            .toList();

    return name.isEmpty
        ? filtereduserInformation
        : filtereduserInformation
            .where(
                (item) => item.name.toLowerCase().contains(name.toLowerCase()))
            .toList();
  }
  */

  List<Permission> filterPermissionInformation(String name) {
    final filteredPermissionInformation = widget.isRedeem
        ? widget.usersInformation
            .where((permission) =>
                permission.status == true &&
                permission.user.roles!.any((role) => role.role == 'visitante'))
            .toList()
        : widget.usersInformation
            .where((permission) =>
                permission.status == false &&
                permission.user.roles!.any((role) => role.role == 'visitante'))
            .toList();

    return name.isEmpty
        ? filteredPermissionInformation
        : filteredPermissionInformation
            .where((permission) => permission.user.name!
                .toLowerCase()
                .contains(name.toLowerCase()))
            .toList();
  }

  void showAcceptUserInvitationDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Aceptar la solicitud de invitacion de usuario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: const Text(
              '¿Estás seguro de que deseas aceptar la invitacion de este usuario?'),
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
                'Aceptar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                //Remove user from the provider
                //updateUserRedeem
                ref
                    .read(permissionInformationProvider.notifier)
                    .updateUserRedeem(user);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToVisitorsDetailsScreen(BuildContext context,
      Permission permission, bool isRedeem, User userInformation) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VisitorsDetailsScreen(
          userInformationState: userInformation,
          userInformation: permission,
          isRedeem: isRedeem,
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
    return Consumer(
      builder: (context, watch, child) {
        final name = ref.watch(nameProvider);
        final filteredName = filterPermissionInformation(name);

        if (filteredName.isEmpty) {
          return const Column(
            children: [
              Center(
                child: Text(
                  'No se encontraron resultados',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 36)
            ],
          );
        }

        var defaultdisplayed = min(defaultDisplayElements, filteredName.length);

        if (widget.displayeElements != null) {
          if (widget.displayeElements! >= defaultDisplayElements) {
            defaultdisplayed = widget.displayeElements!;
          } else {
            defaultdisplayed = min(defaultDisplayElements, filteredName.length);
          }
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: defaultdisplayed,
          itemBuilder: (context, index) {
            if (index < filteredName.length) {
              return GestureDetector(
                onTap: () {
                  ref.read(nameProvider.notifier).updateName('');
                  navigateToVisitorsDetailsScreen(context, filteredName[index],
                      widget.isRedeem, widget.userInformation);
                },
                child: Card(
                  elevation: 0.0,
                  margin: const EdgeInsets.only(bottom: 30),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredName[index].user.name as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredName[index]
                                    .user
                                    .roles!
                                    .map((e) => e.role)
                                    .join(', '),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.isRedeem
                                    ? filteredName[index].invetedBy
                                    : filteredName[index].invetedBy,
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
                                  widget.userInformation.roles!.any(
                                          (role) => role.role == 'encargado')
                                      ? filteredName[index].status == true
                                          ? showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  title: const Text(
                                                    'Eliminar usuario',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        'Eliminar',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (widget
                                                                  .displayeElements !=
                                                              null) {
                                                            ref
                                                                .read(permissionInformationProvider
                                                                    .notifier)
                                                                .removePermission(
                                                                    filteredName[
                                                                        index]);
                                                            widget.onUserRemove!(
                                                                filteredName[
                                                                    index]);
                                                            widget.displayeElements =
                                                                widget.displayeElements! -
                                                                    1;
                                                          } else {
                                                            ref
                                                                .read(permissionInformationProvider
                                                                    .notifier)
                                                                .removePermission(
                                                                    filteredName[
                                                                        index]);
                                                            widget.onUserRemove!(
                                                                filteredName[
                                                                    index]);
                                                          }
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : showAcceptUserInvitationDialog(
                                              context, filteredName[index].user)
                                      : filteredName[index].status == true
                                          ? showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  title: const Text(
                                                    'Eliminar usuario',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        'Eliminar',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (widget
                                                                  .displayeElements !=
                                                              null) {
                                                            ref
                                                                .read(permissionInformationProvider
                                                                    .notifier)
                                                                .removePermission(
                                                                    filteredName[
                                                                        index]);
                                                            widget.onUserRemove!(
                                                                filteredName[
                                                                    index]);
                                                            widget.displayeElements =
                                                                widget.displayeElements! -
                                                                    1;
                                                          } else {
                                                            ref
                                                                .read(permissionInformationProvider
                                                                    .notifier)
                                                                .removePermission(
                                                                    filteredName[
                                                                        index]);
                                                            widget.onUserRemove!(
                                                                filteredName[
                                                                    index]);
                                                          }
                                                        });

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : null;
                                },
                                child: Icon(
                                  widget.userInformation.roles!.any(
                                          (role) => role.role == 'Encargado')
                                      ? filteredName[index].status
                                          ? Icons.close
                                          : Icons.check
                                      : filteredName[index].status
                                          ? Icons.close
                                          : Icons.pending_actions,
                                  color: widget.userInformation.roles!.any(
                                              (role) =>
                                                  role.role == 'Residente') &&
                                          !filteredName[index].status
                                      ? Colors.red
                                      : Colors.black,
                                  size: 24,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
