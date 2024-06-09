import 'package:flutter/material.dart';

import '../../screens/home/accountmanagement/users_screen/qrscreen/qr_screen.dart';

class GenerateQRButton extends StatefulWidget {
  final bool isPassSelected;

  const GenerateQRButton({super.key, required this.isPassSelected});

  @override
  _GenerateQRButtonState createState() => _GenerateQRButtonState();
}

class _GenerateQRButtonState extends State<GenerateQRButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.isPassSelected
              ? () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const QrScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  ).then((value) {
                    setState(() {});
                  });
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
          child: const Text(
            'Generar QR',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
