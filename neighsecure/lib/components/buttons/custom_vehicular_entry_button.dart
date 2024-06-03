import 'package:flutter/material.dart';

class VehicularEntryButton extends StatelessWidget {
  final bool isTablet;
  final VoidCallback onSubmit;

  VehicularEntryButton(
      {Key? key, required this.isTablet, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SizedBox(
        width: isTablet ? 600 : double.infinity,
        child: ElevatedButton(
          onPressed: onSubmit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF001E2C),
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
            'Entrada vehicular',
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
