import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/providers/dummyProviders/testnameprovider.dart';

import '../../../../../../../models/entities/permissions.dart';
import 'visitors_state_screen/visitors_details_screen/visitors_details_screen.dart';

class VisitorsScreen extends ConsumerStatefulWidget {
  VisitorsScreen({
    super.key,
    required this.userInformation,
    required this.permissionsInformation,
    required this.isRedeem,
    this.displayeElements,
    this.onUserRemove,
  });

  late int? displayeElements;

  final User userInformation;

  final List<Permissions> permissionsInformation;

  final Function(Permissions)? onUserRemove;

  bool isRedeem;

  @override
  ConsumerState<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends ConsumerState<VisitorsScreen> {
  var defaultDisplayElements = 3;

  List<User> filtereduserInformation = [];

  final PermissionController _controller = PermissionController();

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

  List<Permissions> filterPermissionInformation(String name) {
    final filteredPermissionInformation = widget.isRedeem
        ? widget.permissionsInformation
            .where((permission) => permission.status == true)
            .toList()
        : widget.permissionsInformation
            .where((permission) => permission.status == false)
            .toList();

    return name.isEmpty
        ? filteredPermissionInformation
        : filteredPermissionInformation
            .where((permission) => permission.userAssociated.name!
                .toLowerCase()
                .contains(name.toLowerCase()))
            .toList();
  }

  void showDeleteUserDialog(BuildContext context, Permissions permission) {
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
              onPressed: () async {
                try {
                  await _controller.deletePermission(permission.id);
                  if (widget.displayeElements != null) {
                    widget.onUserRemove!(permission);
                    widget.displayeElements = widget.displayeElements! - 1;
                  } else {
                    widget.onUserRemove!(permission);
                  }
                  setState(() {});
                } catch (e) {
                  if (kDebugMode) {
                    print('Caught error: $e');
                  }
                } finally {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showAcceptUserInvitationDialog(
      BuildContext context, Permissions permission) {
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
              onPressed: () async {
                try {
                  await _controller.approvePermission(permission.id);
                  Navigator.of(context).pop();
                } catch (e) {
                  if (kDebugMode) {
                    print('Caught error: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToVisitorsDetailsScreen(BuildContext context,
      Permissions permission, bool isRedeem, User userInformation) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VisitorsDetailsScreen(
          userInformationState: userInformation,
          permissionInformation: permission,
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

        final filteredPermission = filterPermissionInformation(name);

        if (filteredPermission.isEmpty) {
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

        var defaultdisplayed =
            min(defaultDisplayElements, filteredPermission.length);

        if (widget.displayeElements != null) {
          if (widget.displayeElements! >= defaultDisplayElements) {
            defaultdisplayed = widget.displayeElements!;
          } else {
            defaultdisplayed =
                min(defaultDisplayElements, filteredPermission.length);
          }
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: defaultdisplayed,
          itemBuilder: (context, index) {
            if (index < filteredPermission.length) {
              return GestureDetector(
                onTap: () {
                  ref.read(nameProvider.notifier).updateName('');
                  navigateToVisitorsDetailsScreen(
                      context,
                      filteredPermission[index],
                      widget.isRedeem,
                      widget.userInformation);
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
                                filteredPermission[index].userAssociated.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.isRedeem
                                    ? filteredPermission[index].userAuth.email!
                                    : filteredPermission[index].userAuth.email!,
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
                                          (role) => role.role == 'Encargado')
                                      ? filteredPermission[index].status == true
                                          ? showDeleteUserDialog(context,
                                              filteredPermission[index])
                                          : showAcceptUserInvitationDialog(
                                              context,
                                              filteredPermission[index])
                                      : filteredPermission[index].status == true
                                          ? showDeleteUserDialog(context,
                                              filteredPermission[index])
                                          : null;
                                },
                                child: Icon(
                                  widget.userInformation.roles!.any(
                                          (role) => role.role == 'Encargado')
                                      ? filteredPermission[index].status == true
                                          ? Icons.close
                                          : Icons.check
                                      : filteredPermission[index].status == true
                                          ? Icons.close
                                          : Icons.pending_actions,
                                  color: widget.userInformation.roles!.any(
                                              (role) =>
                                                  role.role == 'Residente') &&
                                          filteredPermission[index].status ==
                                              true
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
