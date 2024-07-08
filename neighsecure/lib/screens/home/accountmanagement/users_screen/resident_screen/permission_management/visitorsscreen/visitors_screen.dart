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

  bool? isRedeem;

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
    final filteredPermissionInformation = widget.isRedeem == null
        ? widget.permissionsInformation
            .where((permission) => permission.status == null)
            .toList()
        : widget.permissionsInformation
            .where((permission) => permission.status == true)
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
    bool isLoading = false; // Para rastrear el estado de carga

    showDialog(
      context: context,
      barrierDismissible: false, // Evitar cerrar el diálogo al tocar fuera
      builder: (context) {
        return StatefulBuilder(
          // Usar StatefulBuilder para actualizar el contenido del diálogo
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'Eliminar permiso de usuario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: isLoading
                  ? const LinearProgressIndicator() // Mostrar indicador de carga mientras se procesa
                  : const Text(
                      '¿Estás seguro de que deseas eliminar este permiso?'),
              actions: <Widget>[
                if (!isLoading) // Ocultar botón cancelar cuando se está cargando
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                if (!isLoading) // Ocultar botón eliminar cuando se está cargando
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
                      setState(
                          () => isLoading = true); // Mostrar indicador de carga
                      try {
                        final result =
                            await _controller.deletePermission(permission.id);
                        if (result) {
                          // Si la operación es exitosa, mostrar mensaje de éxito
                          Navigator.of(context).pop();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Permiso eliminado con éxito')),
                          );
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print('Caught error: $e');
                        }
                        Navigator.of(context)
                            .pop(); // Cerrar el diálogo en caso de error
                        // Opcionalmente, mostrar mensaje de error
                      }
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void showAcceptUserInvitationDialog(
      BuildContext context, Permissions permission) {
    bool isLoading = false; // Para rastrear el estado de carga

    showDialog(
      context: context,
      barrierDismissible: false, // Evitar cerrar el diálogo al tocar fuera
      builder: (context) {
        return StatefulBuilder(
          // Usar StatefulBuilder para actualizar el contenido del diálogo
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'Aceptar la solicitud de invitación de usuario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: isLoading
                  ? const LinearProgressIndicator() // Mostrar indicador de carga mientras se procesa
                  : const Text(
                      '¿Estás seguro de que deseas aceptar la invitación de este usuario?'),
              actions: <Widget>[
                if (!isLoading) // Ocultar botón cancelar cuando se está cargando
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                if (!isLoading) // Ocultar botón aceptar cuando se está cargando
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
                      setState(
                          () => isLoading = true); // Mostrar indicador de carga
                      try {
                        final result =
                            await _controller.approvePermission(permission.id);
                        if (result) {
                          // Si la operación es exitosa, mostrar mensaje de éxito
                          Navigator.of(context).pop();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invitación aceptada con éxito')),
                          );
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print('Caught error: $e');
                        }
                        Navigator.of(context)
                            .pop(); // Cerrar el diálogo en caso de error
                        // Opcionalmente, mostrar mensaje de error
                      }
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void showRejectInvitationDialog(
      BuildContext context, Permissions permission) {
    bool isLoading = false; // To track the loading state

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on tap outside
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update dialog content
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'Rechazar la solicitud de invitación de usuario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: isLoading
                  ? const LinearProgressIndicator() // Show loading indicator while processing
                  : const Text(
                      '¿Estás seguro de que deseas rechazar la invitación de este usuario?'),
              actions: <Widget>[
                if (!isLoading) // Hide cancel button when loading
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                if (!isLoading) // Hide reject button when loading
                  TextButton(
                    child: const Text(
                      'Rechazar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () async {
                      setState(
                          () => isLoading = true); // Show loading indicator
                      try {
                        final result =
                            await _controller.rejectPermission(permission.id);
                        if (result) {
                          // If operation is successful, show success message
                          Navigator.of(context).pop();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Invitación rechazada con éxito')),
                          );
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print('Caught error: $e');
                        }
                        Navigator.of(context)
                            .pop(); // Close the dialog on error
                        // Optionally, show error message
                      }
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void navigateToVisitorsDetailsScreen(BuildContext context,
      Permissions permission, bool? isRedeem, User userInformation) {
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
                                filteredPermission[index].userAuth.email!,
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
                            Row(
                              children: [
                                if (widget.userInformation.roles!.any(
                                        (role) => role.role == 'Encargado') &&
                                    filteredPermission[index].status ==
                                        null) ...[
                                  GestureDetector(
                                    onTap: () {
                                      // Lógica para aceptar el permiso
                                      showAcceptUserInvitationDialog(
                                          context, filteredPermission[index]);
                                    },
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                      width: 12), // Espacio entre iconos
                                  GestureDetector(
                                    onTap: () {
                                      // Lógica para rechazar el permiso
                                      showRejectInvitationDialog(
                                          context, filteredPermission[index]);
                                    },
                                    child: const Icon(
                                      Icons.not_interested_rounded,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ] else if (widget.userInformation.roles!.any(
                                        (role) => role.role == 'Encargado') &&
                                    filteredPermission[index].status ==
                                        true) ...[
                                  GestureDetector(
                                    onTap: () {
                                      // Lógica para eliminar el permiso
                                      showDeleteUserDialog(
                                          context, filteredPermission[index]);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                ] else if (filteredPermission[index].status ==
                                    true) ...[
                                  GestureDetector(
                                    onTap: () {
                                      // Lógica para eliminar el permiso si es necesario
                                      showDeleteUserDialog(
                                          context, filteredPermission[index]);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                ] else if (widget.userInformation.roles!.any(
                                        (role) => role.role == 'Residente') &&
                                    filteredPermission[index].status ==
                                        null) ...[
                                  // Icono de "Pendiente por aprobar" para usuarios Residente
                                  const Icon(
                                    Icons.hourglass_empty,
                                    color: Colors.orange,
                                    size: 24,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
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
