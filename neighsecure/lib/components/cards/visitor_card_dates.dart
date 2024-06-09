import 'package:flutter/material.dart';
import 'package:neighsecure/models/entities/permission.dart';

class VisitDateCard extends StatelessWidget {
  final Permission pass;
  final bool isSelected;

  const VisitDateCard({super.key, required this.pass, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Visita ${pass.type}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Estado: ${pass.status ? 'Vigente' : 'Caducado'}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Fecha y hora: ${pass.startDate} - ${pass.endDate}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
