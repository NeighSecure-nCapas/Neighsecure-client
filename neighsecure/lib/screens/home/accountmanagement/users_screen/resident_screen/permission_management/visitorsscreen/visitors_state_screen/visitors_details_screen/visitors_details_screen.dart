import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/repositories/permission_repository/permission_repository.dart';

import '../../../../../../../../../models/entities/permissions.dart';
import '../../../../../../../../../models/entities/user.dart';
import '../../../../../../../../splashscreen/splash_screen.dart';

class VisitorsDetailsScreen extends ConsumerStatefulWidget {
  VisitorsDetailsScreen(
      {super.key,
      required this.permissionInformation,
      required this.isRedeem,
      required this.userInformationState});

  final Permissions permissionInformation;

  final User userInformationState;

  bool? isRedeem;

  @override
  ConsumerState<VisitorsDetailsScreen> createState() =>
      _VisitorsDetailsScreenState();
}

class _VisitorsDetailsScreenState extends ConsumerState<VisitorsDetailsScreen> {
  Permissions permissionDetails = Permissions(
    id: '',
    type: '',
    startDate: '',
    endDate: '',
    startTime: '',
    endTime: '',
    generationDate: '',
    days: [],
    homeId: '',
    homeNumber: '',
    address: '',
    userId: '',
    status: false,
    isValid: false,
    entries: [],
    userAssociated: User(
      id: '',
      name: '',
      email: '',
      phone: '',
      roles: [],
    ),
    userAuth: User(
      id: '',
      name: '',
      email: '',
      phone: '',
      roles: [],
    ),
  );

  final PermissionController _controller = PermissionController();

  final PermissionRepository _repository = PermissionRepository();

  StreamController? _streamController;

  @override
  void initState() {
    super.initState();
    _loadPermissionDetails();
  }

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  Future<void> _loadPermissionDetails() async {
    await _controller.getPermission(widget.permissionInformation.id);
    permissionDetails = (await _repository.retrieveDetails())!;
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
                'Eliminar usuario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: isLoading
                  ? const CircularProgressIndicator() // Mostrar indicador de carga mientras se procesa
                  : const Text(
                      '¿Estás seguro de que deseas eliminar a este usuario?'),
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
                          Navigator.of(context).pop(); // Cerrar el diálogo
                          // Mostrar mensaje de éxito en un nuevo diálogo o snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Usuario eliminado con éxito')),
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
                  ? const CircularProgressIndicator() // Mostrar indicador de carga mientras se procesa
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
                          Navigator.of(context).pop(); // Cerrar el diálogo
                          // Mostrar mensaje de éxito en un nuevo diálogo o snackbar
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
                  ? const CircularProgressIndicator() // Show loading indicator while processing
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
                          Navigator.of(context).pop(); // Close the dialog
                          // Show success message in a new dialog or snackbar
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

  @override
  Widget build(BuildContext context) {
    var entryHoursList = permissionDetails.entries ?? [];

    return FutureBuilder(
        future: _loadPermissionDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SplashScreen(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar la información'),
            );
          } else {
            return SafeArea(
                child: Scaffold(
              body: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Detalles de visitante',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.badge_outlined,
                              color: Colors.black,
                              size: 36,
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.permissionInformation.userAssociated
                                        .name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Invitado por ${widget.permissionInformation.userAuth.name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    const SizedBox(height: 30),
                    Text(
                      widget.permissionInformation.type == 'Unica'
                          ? 'Visita única'
                          : 'Visita multiple',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.permissionInformation.status == true
                          ? 'Estado: Completado'
                          : 'Estado: Pendiente',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fecha de inicio: ${widget.permissionInformation.startDate}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fecha de finalización: ${widget.permissionInformation.endDate}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hora de inicio: ${widget.permissionInformation.startTime}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hora de finalización: ${widget.permissionInformation.endTime}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: entryHoursList.map<Widget>((entryHour) {
                        return Column(
                          children: [
                            entryHour.isEmpty
                                ? const SizedBox()
                                : Text(
                                    'Hora de entrada: $entryHour:$entryHour',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                            const SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.userInformationState.roles!
                            .any((role) => role.role == 'Encargado') &&
                        widget.permissionInformation.status == null) ...[
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para aceptar el permiso
                          showAcceptUserInvitationDialog(
                              context, widget.permissionInformation);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFF001E2C)),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 48,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Aceptar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 12), // Espacio entre botones
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para rechazar el permiso
                          showRejectInvitationDialog(
                              context, widget.permissionInformation);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.grey,
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 48,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Rechazar',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ] else if (widget.userInformationState.roles!
                            .any((role) => role.role == 'Encargado') &&
                        widget.permissionInformation.status == true) ...[
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para eliminar el permiso
                          showDeleteUserDialog(
                              context, widget.permissionInformation);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.red,
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 48,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Eliminar',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ] else if (widget.permissionInformation.status == true) ...[
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para eliminar el permiso si es necesario
                          showDeleteUserDialog(
                              context, widget.permissionInformation);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.red,
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 48,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Eliminar',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ] else if (widget.userInformationState.roles!
                            .any((role) => role.role == 'Residente') &&
                        widget.permissionInformation.status == null) ...[
                      // Icono de "Pendiente por aprobar" para usuarios Residente
                      const Icon(
                        Icons.hourglass_empty,
                        color: Colors.orange,
                        size: 24,
                      ),
                    ],
                  ],
                ),
              ),
            ));
          }
        });
  }
}
