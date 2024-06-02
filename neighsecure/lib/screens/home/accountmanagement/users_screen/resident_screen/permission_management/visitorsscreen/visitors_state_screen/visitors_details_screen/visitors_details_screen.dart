import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../models/entities/user.dart';
import '../../../../../../../../../providers/testing_user_information_notifier.dart';

class VisitorsDetailsScreen extends ConsumerStatefulWidget {
  const VisitorsDetailsScreen({
    super.key,
    required this.userInformation,
  });

  final User userInformation;

  @override
  ConsumerState<VisitorsDetailsScreen> createState() => _VisitorsDetailsScreenState();
}

class _VisitorsDetailsScreenState extends ConsumerState<VisitorsDetailsScreen> {

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
                ref.read(userInformationProvider.notifier).updateUserRedeem(userInformation);
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

    var entryHoursList = widget.userInformation.entries ?? [];

    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                            widget.userInformation.name,
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
                            'Residennte ${widget.userInformation}',
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
              widget.userInformation.permissions.first.type == 'single'
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
              widget.userInformation.permissions.first.type == 'multiple'
                  ? 'Estado: Completado'
                  : 'Estado: Pendiente',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: entryHoursList.map<Widget>((entryHour) {
                return Column(
                  children: [
                    Text(
                      'Hora de entrada: $entryHour',
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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              widget.userInformation.permissions.first.status == true ?
               _submit(widget.userInformation) :
              _acceptVisit(widget.userInformation);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                widget.userInformation.permissions.first.status == true
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
              widget.userInformation.permissions.first.status == true
                  ? 'Eliminar'
                  : 'Aceptar visita',
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
}
