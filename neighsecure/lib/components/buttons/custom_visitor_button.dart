import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/key_controller.dart';
import 'package:neighsecure/models/entities/permissions.dart';

import '../../screens/home/accountmanagement/users_screen/qrscreen/qr_screen.dart';

class GenerateQRButton extends StatefulWidget {
  const GenerateQRButton({
    super.key,
    required this.isPassSelected,
    required this.permission,
  });

  final bool isPassSelected;

  final Permissions permission;

  @override
  _GenerateQRButtonState createState() => _GenerateQRButtonState();
}

class _GenerateQRButtonState extends State<GenerateQRButton> {
  final KeyController keyController = KeyController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.isPassSelected && !keyController.isLoading.value
              ? () async {
                  bool success = await keyController
                      .validatePermission(widget.permission.id);
                  if (success) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            QrScreen(permission: widget.permission),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Mensaje'),
                          content: const Text('No se pudo generar el QR'),
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
                    );
                  }
                }
              : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              widget.isPassSelected ? const Color(0xFF001E2C) : Colors.grey,
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
          child: ValueListenableBuilder<bool>(
            valueListenable: keyController.isLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return const Text(
                  'Generar QR',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
