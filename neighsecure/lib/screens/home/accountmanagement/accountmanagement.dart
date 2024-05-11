import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../housemanagement/housemanagement.dart';
import '../qrscreen/qrscreen.dart';
import '../ticketsmanagement/ticketsmanagement.dart';

class AccountManagement extends ConsumerStatefulWidget {
  const AccountManagement({super.key});
  @override
  ConsumerState<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends ConsumerState<AccountManagement> {
  var typeOfUser = 'User';
  var userInformation = {
    'name': 'John Doe',
    'email': 'johndave@gmail.com',
    'phone': '12345678',
    'role': 'encargado',
  };

  @override
  Widget build(BuildContext context) {
    Widget mainContent = SafeArea(
        child: Scaffold(
      body: Center(
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
                  'Bienvenido',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      color: Colors.black,
                      size: 36,
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userInformation['name']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Residennte ${userInformation['role']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          )
                        ],
                      ),
                    )
                  ],
                )),
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
                      'Selecciona alguna de los módulos o genera un QR para acceder a la residencial.',
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HouseManagement(),
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
              child: Card(
                elevation: 0.0,
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.cottage_outlined,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  SizedBox(width: 21),
                                  Text(
                                    'Gestionar hogar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 12),
                                        Text(
                                          'En este modulo podrás administrar los miembros de tu hogar.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(width: 60),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const TicketsManagement(),
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
              child: Card(
                elevation: 0.0,
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                              SizedBox(width: 21),
                              Text(
                                'Gestionar visitas',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(
                                      'En este modulo podrás administrar tus visitas. ',style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                      SizedBox(width: 60),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const QrScreen(),
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
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF001E2C),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 28,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: const Text(
              'Generar QR',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ));

    return mainContent;
  }
}
