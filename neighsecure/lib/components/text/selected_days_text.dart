import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDaysText extends StatelessWidget {
  final List<int>? selectedDays;

  SelectedDaysText({required this.selectedDays});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        'Días seleccionados: ${selectedDays?.map((e) => DateFormat.E().format(DateTime(2024, 1, e))).join(', ')}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }
}
