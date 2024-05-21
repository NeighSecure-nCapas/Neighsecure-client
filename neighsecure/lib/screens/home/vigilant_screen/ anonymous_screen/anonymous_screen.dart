import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnonymousScreen extends ConsumerStatefulWidget {
  const AnonymousScreen({super.key});

  @override
  _AnonymousScreenState createState() => _AnonymousScreenState();
}

class _AnonymousScreenState extends ConsumerState<AnonymousScreen> {

  String _description = '';

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    //Save in the provider

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.badge_outlined,
                        color: Colors.black,
                        size: 36,
                      ),
                      const SizedBox(width: 32),
                      const Text(
                        'Agregar una entrada anónima',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: 32,
                          ),
                          SizedBox(width: 24),
                          Expanded(
                              child: Text(
                            'Por favor ingresa un comentario con la información necesaria para agregar una entrada anónima.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          )),
                        ],
                      )),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 250,
                        maxLines: 10,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          labelText: 'Comentario',
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          alignLabelWithHint: true,
                          //Color F3F3F3
                          fillColor: Colors.grey[100], // background color
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none, // border color
                          ),
                        ),
                        obscureText: false,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 2 ||
                              value.trim().length > 250) {
                            return 'Por favor ingresa un comentario valido, con un mínimo de 2 caracteres y un máximo de 250.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  _description.isNotEmpty
                      ? const Color(0xFF001E2C)
                      : Colors.grey,
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 28,
                  ),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: const Text(
                'Listo',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
