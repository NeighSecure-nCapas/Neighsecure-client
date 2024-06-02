import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/role.dart';

import '../../../../../../../models/entities/user.dart';
import '../../../../../../../providers/testing_user_information_notifier.dart';

class InvitationScreen extends ConsumerStatefulWidget {
  const InvitationScreen(
      {super.key, required this.totalUsers, required this.currentUserCount});

  final int totalUsers;
  final int currentUserCount;

  @override
  ConsumerState<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends ConsumerState<InvitationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';

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

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (widget.currentUserCount >= widget.totalUsers) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text('Error!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              const SizedBox(height: 20),
              const Text(
                  'Se ha excedido el número de residentes permitidos en tu hogar. Si deseas modificar el número de residentes permitidos, por favor contacta a soporte.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF001E2C),
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
                  child: const Text(
                    'Listo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();

      User? user;

      try {
        user = ref
            .read(userInformationProvider)
            .firstWhere((user) => user.email == _email);

      } catch (e) {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text('Error!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text(
                    'No ha sido posible enviadar la invitación al correo electrónico que has proporcionado.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFF001E2C),
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
                    child: const Text(
                      'Listo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }

      if (user != null) {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text('Listo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text(
                    'Hemos enviado una invitación al correo electrónico que has proporcionado. Por favor indica a la persona correspondiente que revise su bandeja de entrada asi como su carpeta de Spam.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      updateUserRole(user!);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFF001E2C),
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
                    child: const Text(
                      'Listo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
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
                  'Agregar un residente',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 52),
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
                      'Por favor ingresa el correo electrónico, de la persona que quieres agregar como residente.',
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
            const SizedBox(height: 52),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      fillColor: Colors.grey[200], // background color
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none, // border color
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    obscureText: false,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ],
              ),
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
              _submit();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                const Color(0xFF001E2C),
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
            child: const Text(
              'Listo',
              style: TextStyle(
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
