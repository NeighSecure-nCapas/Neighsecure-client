import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/terminal_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/repositories/terminal_repository/terminal_repository.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import '../../../../../components/buttons/custom_no_vehicular_entry_button.dart';
import '../../../../../components/buttons/custom_vehicular_entry_button.dart';
import '../../../../../models/entities/terminal.dart';
import 'entry_screen/entry_screen.dart';

class VigilantScreen extends StatefulWidget {
  const VigilantScreen({super.key, required this.userInformation});

  final User userInformation;

  @override
  State<VigilantScreen> createState() => _VigilantScreenState();
}

class _VigilantScreenState extends State<VigilantScreen> {
  final TerminalController _controller = TerminalController();

  final TerminalRepository _repository = TerminalRepository();

  List<Terminal> terminals = [];

  StreamController? _streamController;

  @override
  void initState() {
    super.initState();
    _fetchTerminals();
  }

  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  Future<void> _fetchTerminals() async {
    await _controller.getTerminals();
    terminals = (await _repository.retrieveTerminals())!;
    if (kDebugMode) {
      for (var element in terminals) {
        print(element.toJson());
      }
    }
  }

  Future<void> saveSelectedTerminal(Terminal terminal) async {
    await _repository.saveSelectedTerminal(terminal);
  }

  void _submitCar() {
    Terminal selectedTerminal =
        terminals.firstWhere((element) => element.entryType == 'Vehicular');

    if (kDebugMode) {
      print('Selected terminal: ${selectedTerminal.toJson()}');
    }
    saveSelectedTerminal(selectedTerminal);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EntryScreen(userInformation: widget.userInformation),
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

  void _submitNoCar() {
    Terminal selectedTerminal =
        terminals.firstWhere((element) => element.entryType == 'Peatonal');

    if (kDebugMode) {
      print('Selected terminal: ${selectedTerminal.toJson()}');
    }
    saveSelectedTerminal(selectedTerminal);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EntryScreen(userInformation: widget.userInformation),
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

    return ValueListenableBuilder<bool>(
      valueListenable: _controller.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return const SplashScreen(); // Show loading indicator when isLoading is true
        } else {
          return Scaffold(
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
                          //Return Icon
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
                      ),
                      const SizedBox(height: 175),
                      PedestrianEntryButton(
                        isTablet: isTablet,
                        onSubmit: _submitNoCar,
                      ),
                      const SizedBox(height: 25),
                      VehicularEntryButton(
                        isTablet: isTablet,
                        onSubmit: _submitCar,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )); // Show terminals when isLoading is false
        }
      },
    );
  }
}
