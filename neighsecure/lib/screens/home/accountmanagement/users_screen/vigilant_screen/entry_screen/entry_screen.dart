import 'package:flutter/material.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../../../../../../components/cards/anonymous_visit_card.dart';
import '../../../../../../components/cards/qr_reader_card.dart';
import 'anonumous_screen/anonymous_screen.dart';
import 'qr_reader/qr_reader.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key, required this.userInformation});

  final User userInformation;

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  void _submitToAnonymous() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AnonymousScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _submitToQRreader() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const QRViewExample(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 600;

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
                              widget.userInformation.name as String,
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
                      onTap: () {
                        _submitToQRreader();
                      },
                      child: VisitorCard(
                        isTablet: isTablet,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        _submitToAnonymous();
                      },
                      child: AnonymousVisitCard(
                        isTablet: isTablet,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
