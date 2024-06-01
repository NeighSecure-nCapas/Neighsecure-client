import 'package:flutter/material.dart';

class AnonymousVisitCard extends StatelessWidget {
  final bool isTablet;

  AnonymousVisitCard({Key? key, required this.isTablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isTablet ? 600 : double.infinity,
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(bottom: 30),
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          color: Colors.black,
                          size: 36,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Visita anónima',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Registra una visita anónima',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}