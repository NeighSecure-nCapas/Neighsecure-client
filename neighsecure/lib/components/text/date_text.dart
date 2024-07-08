import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateText extends StatelessWidget {
  final DateTime date;
  final String label;

  const DateText({super.key, required this.date, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        '$label: ${DateFormat('yyyy-MM-dd').format(date)}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }
}
