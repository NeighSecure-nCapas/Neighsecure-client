import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/register_controller.dart';

import '../../../components/buttons/custom_register_button.dart';
import '../../../components/inputs/dui_input_field.dart';
import '../../../components/inputs/phone_input_field.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  var _dui = '';
  var _phoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  final RegisterController _controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ingresa tu DUI',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 52),
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
                        'Por favor ingresa tu numero de DUI, esto nos servirá para ofrecerte un mejor servicio!',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                      ))
                    ],
                  )),
              const SizedBox(height: 52),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DuiInputField(
                      onChanged: (value) {
                        setState(() {
                          _dui = value!;
                        });
                      },
                      onSaved: (value) {
                        _dui = value!;
                      },
                    ),
                    const SizedBox(height: 24),
                    PhoneNumberInputField(
                      onChanged: (value) {
                        setState(() {
                          _phoneNumber = value!;
                        });
                      },
                      onSaved: (value) {
                        _phoneNumber = value!;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CustomSubmitButton(
              onPressed: () {
                if (_dui.isNotEmpty && _phoneNumber.isNotEmpty) {
                  if (kDebugMode) {
                    print('DUI: $_dui');
                    print('Phone Number: $_phoneNumber');
                  }
                  _controller.registerUser(context, _dui, _phoneNumber);
                }
              },
              isTablet: isTablet,
              isDuiNotEmpty: _dui.isNotEmpty,
            );
          }
        },
      ),
    ));
  }
}

/*

CustomSubmitButton(
        onPressed: () {
          if (_dui.isNotEmpty && _phoneNumber.isNotEmpty) {
            if (kDebugMode) {
              print('DUI: $_dui');
              print('Phone Number: $_phoneNumber');
            }
            _controller.registerUser(context, _dui, _phoneNumber);
          }
        },
        isTablet: isTablet,
        isDuiNotEmpty: _dui.isNotEmpty,
      ),
 */
