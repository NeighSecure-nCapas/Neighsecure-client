import 'package:flutter/material.dart';

import '../../splashscreen/splashscreen.dart';
import '../userregister/userregister.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Iniciar sesión o registrarse',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 52),
                if(!_isSigningIn)
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const UserRegister(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                              horizontal: 32,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
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
                if(_isSigningIn)
                  const SplashScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child:  Text(
            'Se aplicarán los Términos y Condiciones y la Política de Privacidad.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        )
    ));
  }
}
