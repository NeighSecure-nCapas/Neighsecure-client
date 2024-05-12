import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/providers/testing_user_information_notifier.dart';
import 'package:neighsecure/providers/testnameprovider.dart';

import '../visitorsscreen/visitorsscreen.dart';

class VisitorsStateScreen extends ConsumerStatefulWidget {
  VisitorsStateScreen(
      {super.key,
        required this.isRedeem,
      });

  bool isRedeem;

  @override
  _VisitorsStateScreenState createState() => _VisitorsStateScreenState();
}

class _VisitorsStateScreenState extends ConsumerState<VisitorsStateScreen>{


  @override
  Widget build(BuildContext context) {

    final name = ref.watch(nameProvider.notifier).state;
    final userInformation = ref.watch(userInformationProvider).where((user) => user['redeem'] == widget.isRedeem.toString()).toList();


    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Administrar visitas',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder: (context, watch, child) {
                    return TextFormField(
                      initialValue: name,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        fillColor: Colors.grey[200], // background color
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none, // border color
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref.read(nameProvider.notifier).updateName(value);
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Consumer(
                  builder: (context, watch, child) {
                    final name = ref.watch(nameProvider.notifier).state;
                    return VisitorsScreen(
                      userInformation: name.isEmpty
                          ? userInformation
                          : userInformation
                          .where((item) => item['name'] == name)
                          .toList(),
                      isRedeem: widget.isRedeem,
                        displayeElements: userInformation.length,
                      onUserRemove: (removedUser) {
                        ref.read(userInformationProvider.notifier).removeUser(removedUser);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}