import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ anonymous_screen/anonymous_screen.dart';
import '../qr_reader/qr_reader.dart';

class EntryScreen extends ConsumerStatefulWidget {
  const EntryScreen({super.key, required this.userInformation});

  final Map<String, dynamic>? userInformation;

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 600;


    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.userInformation?['name']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Vigilante',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 150),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const QRViewExample(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = const Offset(-1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            width: isTablet ? 600 : double.infinity,
                            child: Card(
                              elevation: 0.0,
                              margin: const EdgeInsets.only(bottom: 30),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const  Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.badge_outlined,
                                                color: Colors.black,
                                                size: 36,
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                'Visitante',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Escanea el código QR del visitante para permitir acceso.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 40),
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const AnonymousScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = const Offset(-1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            width: isTablet ? 600 : double.infinity,
                            child: Card(
                              elevation: 0.0,
                              margin: const EdgeInsets.only(bottom: 30),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.badge_outlined,
                                                color: Colors.black,
                                                size: 36,
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                'Visita anónima',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Registra una visita anónima',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, animation, secondaryAnimation) => const AnonymousScreen(),
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  var begin = const Offset(-1.0, 0.0);
                                                  var end = Offset.zero;
                                                  var curve = Curves.ease;

                                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                                  return SlideTransition(
                                                    position: animation.drive(tween),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}