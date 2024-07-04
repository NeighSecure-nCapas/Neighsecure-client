import 'package:flutter/material.dart';

class ErrorRetryWidget extends StatefulWidget {
  final VoidCallback onRetry;
  const ErrorRetryWidget({super.key, required this.onRetry});

  @override
  _ErrorRetryWidgetState createState() => _ErrorRetryWidgetState();
}

class _ErrorRetryWidgetState extends State<ErrorRetryWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Algo salió mal, por favor inténtalo de nuevo para conectarte.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 52),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onRetry,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFF001E2C)),
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 32)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Reintentar',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
