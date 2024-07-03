import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import '../../../controllers/auth_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final AuthController _controller = AuthController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
          valueListenable: _controller.isLoading,
          builder: (context, isLoading, child) {
            if (kDebugMode) {
              print('isLoading OS: $isLoading');
            } // This will print the value of isLoading whenever it changes

            return isLoading
                ? const Center(
                    child: SplashScreen(),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Iniciar sesión o registrarse',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 52),
                          SizedBox(
                            width: isTablet ? 600 : double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _controller
                                      .getAccessTokenResponse(context),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
/*

 */
