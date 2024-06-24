import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/components/cards/house_management_card.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/permission_management.dart';

import '../../../../../components/buttons/custom_elevated_button.dart';
import '../../../../../components/cards/permission_management_card.dart';
import '../../../../../controllers/permission_controller.dart';
import '../../../../../models/entities/user.dart';
import '../../../../../repositories/permission_repository/permission_repository.dart';
import '../qrscreen/qr_screen.dart';
import 'house_management/house_management.dart';

class ResidentScreen extends ConsumerStatefulWidget {
  const ResidentScreen({super.key, required this.userInformation});

  final User userInformation;

  @override
  ConsumerState<ResidentScreen> createState() => _ResidentScreenState();
}

class _ResidentScreenState extends ConsumerState<ResidentScreen> {
  final PermissionController _permissionController = PermissionController();

  final PermissionRepository _permissionRepository = PermissionRepository();

  @override
  void initState() {
    super.initState();
  }

  void submitQR() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QrScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void submitPermission(User user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PermissionManagement(userInformation: user),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void submitHouseManagement(User user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            HouseManagement(userInformation: user),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            Text(
                              widget.userInformation.roles!
                                  .map((role) => role.role)
                                  .join(', '),
                              style: const TextStyle(
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
                  )),
              const SizedBox(height: 30),
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
                        'Selecciona alguna de los módulos o genera un QR para acceder a la residencial.',
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
              const SizedBox(height: 30),
              if (widget.userInformation.roles!
                  .any((role) => role.role == 'Encargado'))
                GestureDetector(
                  onTap: () {
                    submitHouseManagement(widget.userInformation);
                  },
                  child: const HouseManagementCard(),
                ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  submitPermission(widget.userInformation);
                },
                child: const PermissionManagementCard(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomElevatedButton(
        onPressed: () => submitQR(),
        text: 'Generar QR',
      ),
    ));
  }
}
