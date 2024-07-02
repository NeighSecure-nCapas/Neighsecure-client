import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/house_controller.dart';

import '../../../../../../../models/entities/user.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen(
      {super.key,
      required this.totalUsers,
      required this.currentUserCount,
      required this.userInformation});

  final int totalUsers;
  final int currentUserCount;
  final User userInformation;

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';

  String homeId = '';

  final TextEditingController _emailController = TextEditingController();

  final HouseController _controller = HouseController();

  /*

  Future<void> updateAllInformation(User user, Home home) async {
    await ref
        .watch(testingHomeInformationProvider.notifier)
        .addUserAndUpdateRoleAndHome(user, home, home.id);
  }

  Future<void> updateUserRoleAndHome(String email, Home home) async {
    await ref
        .read(userInformationProvider.notifier)
        .updateUserRoleAndHome(email, home.id);
  }

  Future<void> updateUserHome(User user, Home home) async {
    await ref
        .read(testingHomeInformationProvider.notifier)
        .addUserToHome(user, home);
  }


  Future<void> updateInformation(User user, Home home) async {
    await updateAllInformation(user, home);
  }
  */

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (widget.currentUserCount >= widget.totalUsers) {
      _showModalBottomSheet(
        'Error!',
        'Se ha excedido el número de residentes permitidos en tu hogar. Si deseas modificar el número de residentes permitidos, por favor contacta a soporte.',
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();

      _email = _emailController.text;

      if (widget.userInformation.homeId == null) {
        _showModalBottomSheet(
          'Error!',
          'No se ha podido obtener la información de tu hogar. Por favor contacta a soporte.',
        );
        return;
      }

      homeId = widget.userInformation.homeId!;

      try {
        final succes = await _controller.addMember(homeId, _email);

        if (!succes) {
          _showModalBottomSheet(
            'Error!',
            'No ha sido posible enviar la invitación al correo electrónico que has proporcionado. Por favor intenta de nuevo.',
          );
          return;
        }

        _showModalBottomSheet(
          'Listo!',
          'Por favor indica a la persona correspondiente que revise su aplicacion de NeighSecure para ver sus nuevas funciones',
        );
      } catch (e) {
        _showModalBottomSheet(
          'Error!',
          'No ha sido posible enviadar la invitación al correo electrónico que has proporcionado. $e',
        );
      }
    }
  }

  void _showModalBottomSheet(String title, String message) {
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
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 20),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      fillColor: Colors.grey[200], // background color
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none, // border color
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      alignLabelWithHint: true,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller.isLoading,
          builder: (context, isLoading, child) {
            return isLoading
                ? const SizedBox(
                    width: 64,
                    child: LinearProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF001E2C)),
                    ),
                  )
                : SizedBox(
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
                  );
          },
        ),
      ),
    ));
  }
}
