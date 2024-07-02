import 'package:flutter/material.dart';

import '../../controllers/key_controller.dart';
import '../../screens/home/accountmanagement/users_screen/qrscreen/qr_screen.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomElevatedButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final KeyController keyController = KeyController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: !keyController.isLoading.value
              ? () async {
                  bool success = await keyController.validatePermission('');
                  if (success) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            QrScreen(),
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
          child: ValueListenableBuilder<bool>(
            valueListenable: keyController.isLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return Text(
                  text,
                  style: const TextStyle(
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
