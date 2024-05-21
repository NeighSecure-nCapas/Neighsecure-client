import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../qrscreen/qr_screen.dart';

class VisitorScreen extends ConsumerStatefulWidget {
  const VisitorScreen(
      {super.key, required this.userInformation, required this.entryPasses});

  final Map<String, dynamic> userInformation;

  final List<dynamic> entryPasses;

  @override
  ConsumerState<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends ConsumerState<VisitorScreen> {
  int? selectPassIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tus permisos',
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
                              '${widget.userInformation['name']}',
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
                              'Residennte ${widget.userInformation['role']}',
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
              if (widget.userInformation['permisos'] == 'false')
                const Expanded(
                    child: Column(
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
                )),
              if (widget.userInformation['permisos'] == 'true')
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
                          itemCount: widget.entryPasses.length,
                          itemBuilder: (context, index) {
                            var pass = widget.entryPasses[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (pass['typeofVisit'] == 'unica')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                            elevation: selectPassIndex == index
                                                ? 8.0
                                                : 0.0,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Visita ${pass['typeofVisit']}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16)),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    'Estado: ${pass['state']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    'Fecha: ${pass['date']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))),
                                  ),
                                if (pass['typeofVisit'] == 'multiple')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          elevation: selectPassIndex == index
                                              ? 8.0
                                              : 0.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Visita ${pass['typeofVisit']}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16)),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    'Estado: ${pass['state']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    'Dias: ${pass['dias']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    'Rango: ${pass['range']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )),
                                  ),
                                const SizedBox(height: 30),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                selectPassIndex != null
                    ? Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const QrScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      ).then((value) {
                        setState(() {
                          selectPassIndex = null;
                        });
                      })
                    : null;
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  selectPassIndex != null
                      ? const Color(0xFF001E2C)
                      : Colors.grey,
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
                'Generar QR',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
