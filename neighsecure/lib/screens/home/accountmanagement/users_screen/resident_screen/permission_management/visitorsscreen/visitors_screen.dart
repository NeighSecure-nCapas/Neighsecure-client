import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/providers/testing_user_information_notifier.dart';
import 'package:neighsecure/providers/testnameprovider.dart';

import 'visitors_state_screen/visitors_details_screen/visitors_details_screen.dart';

class VisitorsScreen extends ConsumerStatefulWidget {
  VisitorsScreen({
    super.key,
    required this.userInformation,
    required this.isRedeem,
    this.displayeElements,
    this.onUserRemove,
  });

  late int? displayeElements;

  final List<User> userInformation;

  final Function(User)? onUserRemove;

  bool isRedeem;

  @override
  ConsumerState<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends ConsumerState<VisitorsScreen> {
  var defaultDisplayElements = 3;

  List<User> filtereduserInformation = [];

  List<User> filterUserInformation(String name) {
    final filtereduserInformation = widget.isRedeem
        ? widget.userInformation
        .where((item) => item.permissions.first.status == true)
        .toList()
        : widget.userInformation
        .where((item) => item.permissions.first.status == false)
        .toList();

    return name.isEmpty
        ? filtereduserInformation
        : filtereduserInformation
        .where((item) =>
        item.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final name = ref.watch(nameProvider);
        final filteredName = filterUserInformation(name);

        if (filteredName.isEmpty) {
          return const Column(
            children: [
              Center(
                child: Text(
                  'No se encontraron resultados',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 36)
            ],
          );
        }

        var defaultdisplayed = min(defaultDisplayElements, filteredName.length);

        if (widget.displayeElements != null) {
          if (widget.displayeElements! >= defaultDisplayElements) {
            defaultdisplayed = widget.displayeElements!;
          } else {
            defaultdisplayed = min(defaultDisplayElements, filteredName.length);
          }
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: defaultdisplayed,
          itemBuilder: (context, index) {
            if(index < filteredName.length) {
              return GestureDetector(
                onTap: () {
                  ref.read(nameProvider.notifier).updateName('');
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          VisitorsDetailsScreen(
                            userInformation: filteredName[index],
                          ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 0.0,
                  margin: const EdgeInsets.only(bottom: 30),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              color: Colors.black,
                              size: 42,
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredName[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredName[index].roles.map((e) => e.role).join(', '),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredName[index].permissions.map((e) => e.id).join(', '),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                filteredName[index].permissions.first.status == true
                                    ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                      title: const Text(
                                        'Eliminar usuario',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      content: const Text(
                                          '¿Estás seguro de que deseas eliminar a este usuario?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Eliminar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (widget.displayeElements != null) {
                                                ref.read(userInformationProvider.notifier).removeUser(filteredName[index]);
                                                widget.onUserRemove!(filteredName[index]);
                                                widget.displayeElements = widget.displayeElements! - 1;
                                              } else {
                                                ref.read(userInformationProvider.notifier).removeUser(filteredName[index]);
                                                widget.onUserRemove!(filteredName[index]);
                                              }
                                            });

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ) : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      title: const Text(
                                        'Aceptar la solicitud de invitacion de usuario',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      content: const Text(
                                          '¿Estás seguro de que deseas aceptar la invitacion de este usuario?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Aceptar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF001E2C),
                                            ),
                                          ),
                                          onPressed: () {
                                            //Remove user from the provider
                                            ref.read(userInformationProvider.notifier).updateUserRedeem(filteredName[index]);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                filteredName[index].permissions.first.status == true
                                    ? Icons.close
                                    : Icons.check,
                                color: Colors.black,
                                size: 24,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }else{
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

