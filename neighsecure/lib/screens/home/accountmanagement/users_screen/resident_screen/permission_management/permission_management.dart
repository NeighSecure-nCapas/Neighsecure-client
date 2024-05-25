import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_state_screen/visitors_state_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_screen.dart';
import '../../../../../../providers/testing_user_information_notifier.dart';
import '../../../../../../providers/testnameprovider.dart';
import '../../../account_management.dart';

class PermissionManagement extends ConsumerStatefulWidget {
  const PermissionManagement({super.key});
  @override
  ConsumerState<PermissionManagement> createState() =>
      _PermissionManagementState();
}

class _PermissionManagementState extends ConsumerState<PermissionManagement> {
  final _formKey = GlobalKey<FormState>();

  var pendingVisitors = false;

  var completedVisitors = false;


  @override
  Widget build(BuildContext context) {
    final userInformation = ref
        .watch(userInformationProvider)
        .where((user) => user['role'] == 'visitante')
        .toList();

    print(userInformation);

    final name = ref.watch(nameProvider.notifier).state;


    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
//set name to empty
                          ref.read(nameProvider.notifier).updateName('');
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
                        'Administrar visitas',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Consumer(
                    builder: (context, watch, child) {
                      return TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          fillColor: Colors.grey[200], // background color
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none, // border color
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        obscureText: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          ref.read(nameProvider.notifier).updateName(value);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Pendientes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              //set name to empty
                              ref.read(nameProvider.notifier).updateName('');
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      VisitorsStateScreen(
                                    isRedeem: false,
                                  ),
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
                            child: const Text('Ver mas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Consumer(
                        builder: (context, watch, child) {
                          final name = ref.watch(nameProvider.notifier).state;
                          return VisitorsScreen(
                            userInformation: name.isEmpty
                                ? userInformation
                                : userInformation
                                    .where((item) => item['name'] == name)
                                    .toList(),
                            isRedeem: false,
                            onUserRemove: (removedUser) {
                              ref
                                  .read(userInformationProvider.notifier)
                                  .removeUser(removedUser);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Completadas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              //set name to empty
                              ref.read(nameProvider.notifier).updateName('');
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      VisitorsStateScreen(
                                    isRedeem: true,
                                  ),
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
                            child: const Text('Ver mas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Consumer(
                        builder: (context, watch, child) {
                          final name = ref.watch(nameProvider.notifier).state;
                          return VisitorsScreen(
                            userInformation: name.isEmpty
                                ? userInformation
                                : userInformation
                                    .where((item) => item['name'] == name)
                                    .toList(),
                            isRedeem: true,
                            onUserRemove: (removedUser) {
                              ref
                                  .read(userInformationProvider.notifier)
                                  .removeUser(removedUser);
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: SizedBox(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AccountManagement(),
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
                backgroundColor: const Color(0xFF001E2C),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
