import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/components/buttons/custom_visitor_button.dart';
import 'package:neighsecure/models/entities/permission.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../../../../../components/cards/visitor_card.dart';
import '../../../../../components/cards/visitor_card_dates.dart';
import '../../../../../models/entities/entry.dart';

class VisitorScreen extends ConsumerStatefulWidget {
  const VisitorScreen(
      {super.key, required this.userInformation, required this.permissions});

  final User userInformation;
  final List<Permission> permissions;

  @override
  ConsumerState<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends ConsumerState<VisitorScreen> {
  int? selectPassIndex;

  @override
  Widget build(BuildContext context) {

    List<String> entries = widget.userInformation.entries;


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
                              widget.userInformation.name,
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
                              '${widget.userInformation..roles.map((role) => role.role).join(', ')}',
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
              if (!widget.userInformation.permissions.any((permission) => permission.valid))
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
              if (widget.userInformation.permissions.any((permission) => permission.valid))
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

                    ],
                  ),
                )
            ],
          ),
        )),
        bottomNavigationBar: GenerateQRButton(
          isPassSelected: selectPassIndex != null,
        ),
      ),
    );
  }
}

/*
        Expanded(
                        child: ListView.builder(
                          itemCount: entries.length,
                          itemBuilder: (context, index) {
                            var pass = entries[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (pass.permission.type == 'single')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: VisitDateCard(
                                      pass: pass,
                                      isSelected: selectPassIndex == index,
                                    ),
                                  ),
                                if (pass.permission.type == 'multiple')
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectPassIndex = index;
                                      });
                                    },
                                    child: VisitCard(
                                      pass: pass,
                                      isSelected: selectPassIndex == index,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                              ],
                            );
                          },
                        ),
                      ),
 */
