import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../../../../../components/buttons/custom_no_vehicular_entry_button.dart';
import '../../../../../components/buttons/custom_vehicular_entry_button.dart';
import 'entry_screen/entry_screen.dart';

class VigilantScreen extends ConsumerStatefulWidget {
  const VigilantScreen({super.key, required this.userInformation});

  final User userInformation;

  @override
  ConsumerState<VigilantScreen> createState() => _VigilantScreenState();
}

class _VigilantScreenState extends ConsumerState<VigilantScreen> {

  void _submitCar() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => EntryScreen(userInformation: widget.userInformation),
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
  }

  void _submitNoCar(){
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>  EntryScreen(userInformation: widget.userInformation),
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
  }

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
                                  widget.userInformation.name,
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
                      const SizedBox(height:175),
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
          )
      ),
    );
  }
}