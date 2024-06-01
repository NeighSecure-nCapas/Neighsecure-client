import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neighsecure/screens/introduction/welcome_screen/welcome_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width < 600) {
        // If the screen width is less than 600, set the orientation to portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        // If the screen width is more than 600, set the orientation to landscape
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeighSecure',
      theme: ThemeData().copyWith(
        primaryColor: const Color(0xFF2E5DA8), //Primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 46, 93, 168),
        ).copyWith(
          primary: const Color(0xFF001E2C), //Button color
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
