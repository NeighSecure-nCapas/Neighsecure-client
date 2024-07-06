import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/key_controller.dart';
import 'package:neighsecure/repositories/key_repository/key_repository.dart';
import 'package:neighsecure/repositories/user_repository/user_repository.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/entities/key.dart' as mykey;
import '../../../../../models/entities/permissions.dart';
import '../../../../../models/entities/user.dart';

class QrScreen extends StatefulWidget {
  QrScreen({super.key, this.permission});

  Permissions? permission;

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  var _qr = '';
  int _remainingTime = 180;
  Timer? _timer;

  final UserRepository _repositoryUser = UserRepository();

  final KeyRepository _repositoryKey = KeyRepository();

  final KeyController _keyController = KeyController();

  @override
  void initState() {
    super.initState();
    _manageRemainingTime();
  }

  @override
  void dispose() {
    _saveRemainingTime();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _saveRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    final permissionId = widget.permission?.id ?? 'default';
    final remainingTimeKey = '${permissionId}_remainingTime';
    final savedAtKey = '${permissionId}_savedAt';
    await prefs.setInt(remainingTimeKey, _remainingTime);
    await prefs.setInt(savedAtKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _manageRemainingTime() async {
    _keyController.isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    final permissionId = widget.permission?.id ?? 'default';
    final savedAtKey = '${permissionId}_savedAt';
    final remainingTimeKey = '${permissionId}_remainingTime';

    final savedAt = prefs.getInt(savedAtKey);
    final savedRemainingTime = prefs.getInt(remainingTimeKey);

    if (savedAt != null && savedRemainingTime != null) {
      final elapsedTime = (currentTime - savedAt) ~/ 1000;
      _remainingTime = (savedRemainingTime - elapsedTime).clamp(0, 180);
    } else {
      final qrGenerationTime = prefs.getInt('qrGenerationTime') ?? currentTime;
      final elapsedTime = (currentTime - qrGenerationTime) ~/ 1000;
      _remainingTime = (180 - elapsedTime).clamp(0, 180);
    }

    await prefs.setInt(remainingTimeKey, _remainingTime);
    await prefs.setInt(savedAtKey, currentTime);

    _keyController.isLoading.value = false;

    if (_remainingTime > 0) {
      _startTimer();
    }
  }

  Future<mykey.Key?> getKeyInfo() async {
    mykey.Key? key = await _repositoryKey.retrieveKeyLocally();
    mykey.Key? keyInfo;

    if (key != null) {
      keyInfo = key; // Replace 'keyId' with the actual property name
    } else {
      throw Exception('Key not found');
    }

    return keyInfo;
  }

  Future<String?> getUserRole() async {
    User? user = await _repositoryUser.retrieveUserLocally();
    String? roleRet;

    if (user != null && user.roles!.isNotEmpty) {
      roleRet = user.roles!.first.role;
    }

    return roleRet;
  }

  Future<String> generateString() async {
    mykey.Key? key = await getKeyInfo();
    String? role = await getUserRole();

    if (kDebugMode) {
      print(key?.id);
      print(key?.generationDate);
      print(key?.generationDay);
      print(key?.generationTime);
      print(role);
    }

    return '${key?.id}/$role/${key?.generationDate}/${key?.generationDay}/${key?.generationTime}';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            _remainingTime--;
          });
        }
      }
    });
  }

  void _changeQr() async {
    /*
    const allowedChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const length = 10;

    final random = Random();

    final randomString = List.generate(length, (index) {
      return allowedChars[random.nextInt(allowedChars.length)];
    }).join();
    */

    _keyController.isLoading.value = true;

    final randomString = await generateString();

    if (kDebugMode) {
      print(randomString);
    }

    setState(() {
      _qr = randomString;
      _remainingTime = 10;
    });

    _startTimer();
    _keyController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _keyController.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const SplashScreen();
          } else {
            return SafeArea(
                child: Scaffold(
              body: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Generar QR',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey,
                              size: 32,
                            ),
                            SizedBox(width: 24),
                            Expanded(
                                child: Text(
                              'Muestra el siguiente código QR a uno de los vigilantes encargados. Si el código se vence, vuelve a generarlo.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ))
                          ],
                        )),
                    const SizedBox(height: 96),
                    QrImageView(
                      data: _qr,
                      version: QrVersions.auto,
                      size: 275.0,
                    ),
                    const SizedBox(height: 18),
                    Column(
                      children: [
                        const Text(
                          'Tiempo restante',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatTime(_remainingTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    if (_remainingTime == 0)
                      const Text(
                        'Vencido',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _remainingTime > 0
                        ? null
                        : () async {
                            String? permissionId = widget.permission?.id;
                            if (permissionId != null) {
                              bool isValid = await _keyController
                                  .validatePermission(permissionId);
                              if (isValid) {
                                _changeQr();
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Permission is not valid or expired. Please validate again.')),
                                );
                              }
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        _remainingTime > 0
                            ? Colors.grey
                            : const Color(0xFF001E2C),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 28,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Generar de nuevo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ));
          }
        });
  }
}

String _formatTime(int timeInSeconds) {
  final minutes = timeInSeconds ~/ 60;
  final seconds = timeInSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
