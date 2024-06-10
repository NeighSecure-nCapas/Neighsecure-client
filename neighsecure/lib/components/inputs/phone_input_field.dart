import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberInputField extends StatefulWidget {
  final Function(String?) onChanged;
  final Function(String?) onSaved;

  const PhoneNumberInputField(
      {super.key, required this.onChanged, required this.onSaved});

  @override
  _PhoneNumberInputFieldState createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController(text: '+503');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!_controller.text.startsWith('+503')) {
        _controller.text = '+503';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      maxLength: 12,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
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
        PhoneNumberInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid phone number';
        } else {
          String pattern = r'^\+503[67]\d{7}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (!newText.startsWith('+503')) {
      if (oldValue.text.startsWith('+503') && newValue.text.length < 4) {
        newText = oldValue.text;
      } else {
        newText = '+503${newText.substring(3)}';
      }
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
