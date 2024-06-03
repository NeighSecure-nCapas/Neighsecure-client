import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../components/text/terms_and_privacy_text.dart';
import '../../splashscreen/splash_screen.dart';
import '../user_register/user_register.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 600;

    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Iniciar sesión o registrarse',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 52),
                    if (!_isSigningIn)
                      SizedBox(
                          width: isTablet ? 600 : double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const UserRegister(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xFF001E2C),
                              ),
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 32,
                                ),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/googleoriginal.png',
                                  width: 28,
                                  height: 28,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Continuar con Google',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    if (_isSigningIn) const SplashScreen(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: TermsAndPrivacyNotice(
              onTermsTap: () {
                if (kDebugMode) {
                  print('Terms and Conditions');
                }
              },
              onPrivacyTap: () {
                if (kDebugMode) {
                  print('Privacy Policy');
                }
              },
            )));
  }
}
