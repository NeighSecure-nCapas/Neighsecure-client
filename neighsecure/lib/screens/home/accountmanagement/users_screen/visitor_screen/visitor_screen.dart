import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neighsecure/components/buttons/custom_visitor_button.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/repositories/permission_repository/permission_repository.dart';

import '../../../../../components/cards/visitor_card.dart';
import '../../../../../components/cards/visitor_card_dates.dart';
import '../../../../../components/erroscomponetes/error_container.dart';
import '../../../../../models/entities/permissions.dart';
import '../../../../splashscreen/splash_screen.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key, required this.userInformation});

  final User userInformation;

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  int? selectPassIndex;

  bool isLoading = false;

  List<Permissions> permissions = [];

  final PermissionController _permissionController = PermissionController();

  final PermissionRepository _permissionRepository = PermissionRepository();

  StreamController? _streamController;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  @override
  void dispose() {
    selectPassIndex = null;
    _streamController?.close();
    super.dispose();
  }

  Future<void> _loadPermissions() async {
    await _permissionController.getMyPermissions();
    permissions = (await _permissionRepository.retrievePermissions())!;
    permissions = permissions
        .where((permission) =>
            permission.status == true && permission.isValid == true)
        .toList();
  }

  //ae3e3775-7cad-4208-8df6-e0f53055d30e
  //a30711b9-e1df-4a20-8190-a89c37138f40
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Tus permisos',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 32),
                IconButton(
                    alignment: Alignment.topCenter,
                    onPressed: () {
                      setState(() {});
                      selectPassIndex = null;
                    },
                    icon: const Icon(Icons.refresh, size: 32))
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
                            widget.userInformation.name!,
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
            Expanded(
                child: FutureBuilder(
              future: _loadPermissions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SplashScreen(),
                  );
                } else if (snapshot.hasError) {
                  return ErrorRetryWidget(
                    onRetry: () {
                      setState(() {});
                    },
                  ); // Show an error message if _loadPermissions completed with an error
                } else if (permissions.isEmpty) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 148),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey,
                              size: 64,
                            ),
                            SizedBox(height: 20),
                            Expanded(
                                child: Text(
                              'Por el momento no tienes ningún permiso, en caso de ser un residente contacta con tu residente encargado para ser agregado a tu hogar.  ',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ))
                          ],
                        ),
                      )),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                'Selecciona alguno de los permisos que tienes disponibles para obtener tu clave QR.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.start,
                                softWrap: true,
                              )),
                            ],
                          )),
                      const SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: permissions.length,
                          itemBuilder: (context, index) {
                            var element = permissions[index];
                            Widget card;
                            if (element.type == 'Unica') {
                              card = GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectPassIndex = index;
                                  });
                                },
                                child: VisitDateCard(
                                  pass: element,
                                  isSelected: selectPassIndex == index,
                                ),
                              );
                            } else if (element.type == 'Multiple') {
                              card = GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectPassIndex = index;
                                  });
                                },
                                child: VisitCard(
                                  pass: element,
                                  isSelected: selectPassIndex == index,
                                ),
                              );
                            } else {
                              card =
                                  Container(); // return an empty container if none of the conditions are met
                            }
                            return card;
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
          ],
        ),
      )),
      bottomNavigationBar: FutureBuilder(
        future: _loadPermissions(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              selectPassIndex != null) {
            return GenerateQRButton(
              permission: permissions[selectPassIndex!],
              isPassSelected: permissions[selectPassIndex!].status != null,
            );
          } else {
            return const SizedBox
                .shrink(); // Retorna un widget vacío mientras se está cargando
          }
        },
      ),
    );
  }
}

/*




Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              'Selecciona alguno de los permisos que tienes disponibles para obtener tu clave QR.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            )),
                          ],
                        )),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: permissions.length,
                        itemBuilder: (context, index) {
                          var element = permissions[index];
                          Widget card;
                          if (element.type == 'Unica') {
                            card = GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectPassIndex = index;
                                });
                              },
                              child: VisitDateCard(
                                pass: element,
                                isSelected: selectPassIndex == index,
                              ),
                            );
                          } else if (element.type == 'Multiple') {
                            card = GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectPassIndex = index;
                                });
                              },
                              child: VisitCard(
                                pass: element,
                                isSelected: selectPassIndex == index,
                              ),
                            );
                          } else {
                            card =
                                Container(); // return an empty container if none of the conditions are met
                          }
                          return card;
                        },
                      ),
                    ),
                  ],
                ),
              )


if (widget.userInformation.permissions.first
                                        .type ==
                                    'single')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: VisitDateCard(
                                      pass: widget
                                          .userInformation.permissions.first,
                                      isSelected: selectPassIndex == index,
                                    ),
                                  ),
                                if (widget.userInformation.permissions.first
                                        .type ==
                                    'multiple')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: VisitCard(
                                      pass: widget
                                          .userInformation.permissions.first,
                                      isSelected: selectPassIndex == index,
                                    ),
                                  ),
                                const SizedBox(height: 30),
 */
