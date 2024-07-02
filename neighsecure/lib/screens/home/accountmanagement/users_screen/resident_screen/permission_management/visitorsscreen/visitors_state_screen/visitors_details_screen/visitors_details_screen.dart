import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/repositories/permission_repository/permission_repository.dart';

import '../../../../../../../../../models/entities/permissions.dart';
import '../../../../../../../../../models/entities/user.dart';
import '../../../../../../../../../providers/dummyProviders/testing_permission_information_notifier.dart';
import '../../../../../../../../../providers/dummyProviders/testing_user_information_notifier.dart';
import '../../../../../../../../splashscreen/splash_screen.dart';

class VisitorsDetailsScreen extends ConsumerStatefulWidget {
  VisitorsDetailsScreen(
      {super.key,
      required this.permissionInformation,
      required this.isRedeem,
      required this.userInformationState});

  final Permissions permissionInformation;

  final User userInformationState;

  bool isRedeem;

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

  void _acceptVisit(User userInformation) {
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
                  color: Color(0xFF001E2C),
                ),
              ),
              onPressed: () {
                //Remove user from the provider
                ref
                    .read(permissionInformationProvider.notifier)
                    .updateUserRedeem(userInformation);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submit(User userInformation) {
    FocusScope.of(context).unfocus();

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
                //Remove user from the provider
                ref
                    .read(userInformationProvider.notifier)
                    .removeUser(userInformation);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
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
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.userInformationState.roles!
                              .any((userRole) => userRole.role == 'Encargado')
                          ? (widget.permissionInformation.status == true
                              ? _submit(
                                  widget.permissionInformation.userAssociated)
                              : _acceptVisit(
                                  widget.permissionInformation.userAssociated))
                          : (widget.permissionInformation.status == true
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Solo un encargado puede eliminar'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content:
                                          const Text('Esperando aprobacion'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ));
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        widget.permissionInformation.status == true
                            ? const Color(0xFFBA1A1A)
                            : const Color(0xFF001E2C),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 28,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      widget.userInformationState.roles!
                              .any((userRole) => userRole.role == 'Encargado')
                          ? (widget.permissionInformation.status == true
                              ? 'Eliminar'
                              : 'Aceptar visita')
                          : (widget.permissionInformation.status == true
                              ? 'Solo un encargado puede eliminar'
                              : 'Esperando aprobacion'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ));
          }
        });
  }
}
