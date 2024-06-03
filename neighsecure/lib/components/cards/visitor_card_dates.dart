import 'package:flutter/material.dart';
import 'package:neighsecure/models/entities/permission.dart';

class VisitDateCard extends StatelessWidget {
  final Permission pass;
  final bool isSelected;

  VisitDateCard({Key? key, required this.pass, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: isSelected ? 8.0 : 0.0,
        color: Theme.of(context).scaffoldBackgroundColor,
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
