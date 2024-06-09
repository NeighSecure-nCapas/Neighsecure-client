import 'package:flutter/material.dart';

class InvitationButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const InvitationButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: onSubmit,
          backgroundColor: const Color(0xFF001E2C),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
