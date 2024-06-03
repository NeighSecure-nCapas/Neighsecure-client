import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndPrivacyNotice extends StatelessWidget {
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  TermsAndPrivacyNotice(
      {Key? key, required this.onTermsTap, required this.onPrivacyTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey,
          ),
          children: [
            const TextSpan(
              text: 'Se aplicarán los ',
            ),
            TextSpan(
              text: 'Términos y Condiciones',
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTermsTap,
            ),
            const TextSpan(
              text: ' y la ',
            ),
            TextSpan(
              text: 'Política de Privacidad.',
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
            ),
          ],
        ),
      ),
    );
  }
}
