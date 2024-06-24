import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/permission.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/adding_visit/adding_visit.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_screen.dart';
import 'package:neighsecure/screens/home/accountmanagement/users_screen/resident_screen/permission_management/visitorsscreen/visitors_state_screen/visitors_state_screen.dart';

import '../../../../../../components/buttons/custom_floating_action_button.dart';
import '../../../../../../models/entities/home.dart';
import '../../../../../../providers/dummyProviders/testing_home_information_notifier.dart';
import '../../../../../../providers/dummyProviders/testing_permission_information_notifier.dart';
import '../../../../../../providers/dummyProviders/testnameprovider.dart';

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

  late final Home home;

  List<Permission> usersInformation = [];

  Home getHomeInCharge(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .firstWhere((home) => home.encargado == user);
  }

  Home getHomeResident(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .firstWhere((home) => home.users.contains(user));
  }

  void navigateToAddVisit(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddingVisit(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void navigateToVisitorsState1Screen(BuildContext context, bool isRedeem,
      List<Permission> permissions, User user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VisitorsStateScreen(
          userInformation: user,
          usersInformation: permissions,
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

  void navigateToVisitorsState2Screen(BuildContext context, bool isRedeem,
      List<Permission> permissions, User user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VisitorsStateScreen(
          userInformation: user,
          usersInformation: permissions,
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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userInformation.roles!.any((role) => role.role == 'encargado')) {
      home = getHomeInCharge(widget.userInformation);
    } else if (widget.userInformation.roles!
        .any((role) => role.role == 'residente')) {
      home = getHomeResident(widget.userInformation);
    }

    final permissionsInformation = ref
        .watch(permissionInformationProvider)
        .where((permission) {
          if (widget.userInformation.roles!
              .any((role) => role.role == 'encargado')) {
            return permission.home.id == home.id;
          } else if (widget.userInformation.roles!
              .any((role) => role.role == 'residente')) {
            return permission.home.id == home.id;
          }
          return false;
        })
        .where((permission) =>
            permission.user.roles!.any((role) => role.role == 'visitante'))
        .toList();

    final usersWithUnapprovedPermissions = permissionsInformation
        .where((permission) => !permission.valid)
        .toList();

    final usersWithApprovedPermissions =
        permissionsInformation.where((permission) => permission.valid).toList();

    if (kDebugMode) {
      print('Approved permissions');
      for (var element in usersWithApprovedPermissions) {
        print(element.user.name);
      }
      print('Unapproved permissions');
      for (var element in usersWithUnapprovedPermissions) {
        print(element.user.name);
      }
    }

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
                              navigateToVisitorsState2Screen(
                                  context,
                                  false,
                                  usersWithUnapprovedPermissions,
                                  widget.userInformation);
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
                            userInformation: widget.userInformation,
                            usersInformation: name.isEmpty
                                ? permissionsInformation
                                : permissionsInformation
                                    .where((item) => item.user.name == name)
                                    .toList(),
                            isRedeem: false,
                            onUserRemove: (removedPermission) {
                              ref
                                  .read(permissionInformationProvider.notifier)
                                  .removePermission(removedPermission);
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
                              navigateToVisitorsState1Screen(
                                  context,
                                  true,
                                  usersWithApprovedPermissions,
                                  widget.userInformation);
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
                            userInformation: widget.userInformation,
                            usersInformation: name.isEmpty
                                ? usersWithApprovedPermissions
                                : usersWithApprovedPermissions
                                    .where((item) => item.user.name == name)
                                    .toList(),
                            isRedeem: true,
                            onUserRemove: (removedPermission) {
                              ref
                                  .read(permissionInformationProvider.notifier)
                                  .removePermission(removedPermission);
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
