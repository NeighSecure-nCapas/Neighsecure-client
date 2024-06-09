import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuiInputField extends StatefulWidget {
  final Function(String?) onChanged;
  final Function(String?) onSaved;

  const DuiInputField({super.key, required this.onChanged, required this.onSaved});

  @override
  _DuiInputFieldState createState() => _DuiInputFieldState();
}

class _DuiInputFieldState extends State<DuiInputField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'DUI',
        fillColor: Colors.grey[200],
        // background color
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none, // border color
        ),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        alignLabelWithHint: true,
      ),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
      obscureText: false,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      inputFormatters: [
        DuiInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa un valor valido de DUI';
        } else {
          String pattern = r'^\d{8}-\d$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Please enter a valid DUI';
          }
        }
        return null;
      },
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}

class DuiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newValue.text.length == 8 && oldValue.text.length == 7) {
      newText = '${newValue.text}-';
    } else if (oldValue.text.length == 9 && newValue.text.length == 8) {
      newText = newValue.text.substring(0, 8);
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
