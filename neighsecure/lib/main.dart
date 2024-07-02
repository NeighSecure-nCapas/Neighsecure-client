import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neighsecure/screens/home/accountmanagement/account_management.dart';
import 'package:neighsecure/screens/introduction/user_register/user_register.dart';
import 'package:neighsecure/screens/introduction/welcome_screen/welcome_screen.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import 'controllers/auth_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  App({super.key});

  final AuthController _controller = AuthController();

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
          primary: const Color(0xFF001E2C),
          //Button color
          secondary: const Color(0xFFD7E2FF),
          //Secondary color
          onPrimary: const Color(0xFFFEFBFF),
          //OnPrimary color
          onError: const Color(0xFFBA1A1A),
          //onError color
          surface: const Color(0xFFD7E2FF), //onErrorContainer color
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: FutureBuilder<bool?>(
        future: _controller.isUserValid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.data == true) {
            return const AccountManagement();
          } else if (snapshot.data == null) {
            return const UserRegister();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
