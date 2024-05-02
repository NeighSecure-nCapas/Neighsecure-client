import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neighsecure/screens/welcomescreen/welcomescreen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeighSecure',
      theme: ThemeData().copyWith(
        primaryColor: const Color(0xFF2E5DA8), //Primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 46, 93, 168),
        ).copyWith(
          primary: const Color(0xFF2E5DA8), //Primary color
          secondary: const Color(0xFFD7E2FF), //Secondary color
          onPrimary: const Color(0xFFFEFBFF), //OnPrimary color
          onError: const Color(0xFFBA1A1A), //onError color
          surface: const Color(0xFFD7E2FF), //onErrorContainer color
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
