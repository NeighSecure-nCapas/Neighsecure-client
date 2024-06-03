import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/adding_visit/adding_visit.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_state_screen/visitors_state_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_screen.dart';
import '../../../../../../components/buttons/custom_floating_action_button.dart';
import '../../../../../../providers/testing_user_information_notifier.dart';
import '../../../../../../providers/testnameprovider.dart';

class PermissionManagement extends ConsumerStatefulWidget {
  const PermissionManagement({super.key, required this.userInformation});

  final User userInformation;

  @override
  ConsumerState<PermissionManagement> createState() =>
      _PermissionManagementState();
}

class _PermissionManagementState extends ConsumerState<PermissionManagement> {
  final _formKey = GlobalKey<FormState>();

  var pendingVisitors = false;

  var completedVisitors = false;

  late List<User> usersInformation = [];

  void navigateToAddVisit(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AddingVisit(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void navigateToVisitorsState1Screen(BuildContext context, bool isRedeem) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VisitorsStateScreen(
          isRedeem: isRedeem,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
  void navigateToVisitorsState2Screen(BuildContext context, bool isRedeem) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VisitorsStateScreen(
          isRedeem: isRedeem,
        ),
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
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersInformation = ref
        .watch(userInformationProvider)
        .where((user) => user.roles.any((role) => role.role == 'visitante'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    usersInformation = ref
        .watch(userInformationProvider)
        .where((user) => user.roles.any((role) => role.role == 'visitante'))
        .toList();

    if (kDebugMode) {
      print(usersInformation);
    }

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
                              navigateToVisitorsState2Screen(context, false);
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
                                ? usersInformation
                                : usersInformation
                                    .where((item) => item.name == name)
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
                              navigateToVisitorsState1Screen(context, true);
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
                                ? usersInformation
                                : usersInformation
                                    .where((item) => item.name == name)
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
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              navigateToAddVisit(context);
            },
          )),
    );
  }
}
