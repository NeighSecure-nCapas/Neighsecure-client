import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isTablet;
  final bool isDuiNotEmpty;

  CustomSubmitButton(
      {Key? key,
      required this.onPressed,
      required this.isTablet,
      required this.isDuiNotEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isTablet
          ? const EdgeInsets.symmetric(horizontal: 325, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SizedBox(
        width: isTablet ? 600 : double.infinity,
        child: ElevatedButton(
          onPressed: isDuiNotEmpty ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isDuiNotEmpty ? const Color(0xFF001E2C) : Colors.grey,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 28,
              ),
            ),
            shape: MaterialStateProperty.all(
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
    );
  }
}
