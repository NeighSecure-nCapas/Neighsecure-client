import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/providers/testnameprovider.dart';

class VisitorsScreen extends ConsumerStatefulWidget {
  VisitorsScreen(
      {super.key, required this.userInformation, required this.isRedeem});

  final List<Map<String, String>> userInformation;

  bool isRedeem = true;

  @override
  _VisitorsScreenState createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends ConsumerState<VisitorsScreen> {
  List<Map<String, String>> filtereduserInformation = [];

  List<Map<String, String>> filterUserInformation(String name) {
    final filtereduserInformation = widget.isRedeem
        ? widget.userInformation
            .where((item) => item['redeem'] == 'true')
            .toList()
        : widget.userInformation
            .where((item) => item['redeem'] == 'false')
            .toList();

    return name.isEmpty
        ? filtereduserInformation
        : filtereduserInformation
            .where((item) =>
                item['name']?.toLowerCase().contains(name.toLowerCase()) ??
                false)
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
              const SizedBox(height: 36)
            ],
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredName.length,
          itemBuilder: (context, index) {
            return Card(
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
                            filteredName[index]['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            filteredName[index]['role']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            filteredName[index]['inviteBy']!,
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
                            showDialog(
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
                                          filtereduserInformation
                                              .removeAt(index);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
