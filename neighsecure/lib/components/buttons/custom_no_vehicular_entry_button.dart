import 'package:flutter/material.dart';

class PedestrianEntryButton extends StatelessWidget {
  final bool isTablet;
  final VoidCallback onSubmit;

  const PedestrianEntryButton(
      {super.key, required this.isTablet, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SizedBox(
        width: isTablet ? 600 : double.infinity,
        child: ElevatedButton(
          onPressed: onSubmit,
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
            'Entrada peatonal',
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
