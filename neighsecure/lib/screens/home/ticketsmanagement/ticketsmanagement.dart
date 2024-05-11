import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/screens/home/ticketsmanagement/visitorsscreen/visitorsscreen.dart';
import '../../../providers/testingpendingvisitorsprovider.dart';
import '../../../providers/testnameprovider.dart';
import '../accountmanagement/accountmanagement.dart';

class TicketsManagement extends ConsumerStatefulWidget {
  const TicketsManagement({super.key});
  @override
  ConsumerState<TicketsManagement> createState() => _TicketsManagementState();
}

class _TicketsManagementState extends ConsumerState<TicketsManagement> {
  String _name = '';

  final _formKey = GlobalKey<FormState>();

  List<Map<String, String>> userInformation = [
    {
      'name': 'Victor Rene',
      'role': 'visitante',
      'email': 'caliente@gmail.com',
      'tipoOfTicket': 'true',
      'redeem': 'false',
      'inviteBy': 'Pamela Gomez'
    },
    {
      'name': 'Alejandro Campos',
      'role': 'visitante',
      'email': 'caliente@gmail.com',
      'tipoOfTicket': 'false',
      'Entry hours': [
        '2024-04-25 10:00',
        '2024-04-25 11:00',
        '2024-04-25 12:00',
        '2024-04-25 13:00',
        '2024-04-25 14:00',
        '2024-04-25 15:00',
      ].join(','),
      'redeem': 'false',
      'inviteBy': 'Carlos Gomez',
    },
    {
      'name': 'Billy Caliente',
      'role': 'visitante',
      'email': 'caliente@gmail.com',
      'tipoOfTicket': 'true',
      'redeem': 'true',
      'inviteBy': 'Fernando Olivo'
    },
    {
      'name': 'Melvin Diaz',
      'role': 'visitante',
      'email': 'caliente@gmail.com',
      'tipoOfTicket': 'false',
      'Entry hours': [
        '2024-04-25 10:00',
        '2024-04-25 11:00',
        '2024-04-25 12:00',
        '2024-04-25 13:00',
        '2024-04-25 14:00',
        '2024-04-25 15:00',
      ].join(','),
      'redeem': 'true',
      'inviteBy': 'Diego Viana'
    },
    {
      'name': 'Alejandro Diaz',
      'role': 'visitante',
      'email': 'caliente@gmail.com',
      'tipoOfTicket': 'false',
      'Entry hours': [
        '2024-04-25 10:00',
        '2024-04-25 11:00',
        '2024-04-25 12:00',
        '2024-04-25 13:00',
        '2024-04-25 14:00',
        '2024-04-25 15:00',
      ].join(','),
      'redeem': 'true',
      'inviteBy': 'Diego Viana'
    },
  ];

  var pendingVisitors = false;

  var completedVisitors = false;

  @override
  Widget build(BuildContext context) {

    final name = ref.watch(nameProvider.notifier).state;

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
                  if(!completedVisitors)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Pendientes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                pendingVisitors = !pendingVisitors;
                                print(pendingVisitors);
                              });
                            },
                            child: const Text('Ver mas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Consumer(
                        builder: (context, watch, child) {
                          final name = ref.watch(nameProvider.notifier).state;
                          return VisitorsScreen(
                              userInformation: name.isEmpty
                                  ? userInformation
                                  : userInformation
                                      .where((item) => item['name'] == name)
                                      .toList(),
                              isRedeem: false);
                        },
                      ),
                    ],
                  ),
                  if(!pendingVisitors)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Completadas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                completedVisitors = !completedVisitors;
                                print(completedVisitors);
                              });
                            },
                            child: const Text('Ver mas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Consumer(
                        builder: (context, watch, child) {
                          final name = ref.watch(nameProvider.notifier).state;
                          return VisitorsScreen(
                              userInformation: name.isEmpty
                                  ? userInformation
                                  : userInformation
                                      .where((item) => item['name'] == name)
                                      .toList(),
                              isRedeem: true);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: SizedBox(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AccountManagement(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                backgroundColor: const Color(0xFF001E2C),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
