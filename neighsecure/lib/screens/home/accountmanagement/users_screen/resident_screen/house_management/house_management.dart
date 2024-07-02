import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neighsecure/controllers/house_controller.dart';
import 'package:neighsecure/models/entities/user.dart';
import 'package:neighsecure/repositories/house_repository/house_repository.dart';

import '../../../../../../components/cards/users_list_card.dart';
import '../../../../../../components/floatingbuttons/invitation_button.dart';
import 'invitationscreen/invitation_screen.dart';

class HouseManagement extends StatefulWidget {
  const HouseManagement({super.key, required this.userInformation});

  final User userInformation;

  @override
  State<HouseManagement> createState() => _HouseManagementState();
}

class _HouseManagementState extends State<HouseManagement> {
  int totalUsers = 0;

  List<User> usersInformation = [];

  final HouseRepository _repository = HouseRepository();

  final HouseController _controller = HouseController();

  final ValueNotifier<bool> _isDeleting = ValueNotifier<bool>(false);

  StreamController? _streamController;

  @override
  void initState() {
    super.initState();
    _loadHouseInformation();
  }

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHouseInformation();
  }

  Future<void> _loadHouseInformation() async {
    await _controller.getHomeMembers(widget.userInformation.homeId);
    usersInformation = (await _repository.retrieveHomeMembersLocally());
    totalUsers = (await _repository.retrieveHomeMembersNumber());
  }

  void _submitToInvitation() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            InvitationScreen(
          totalUsers: totalUsers,
          userInformation: widget.userInformation,
          currentUserCount: usersInformation.length,
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

  void showDeleteUserDialog(BuildContext context, User user) {
    String? userEmail = user.email;
    String? homeId = widget.userInformation.homeId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            ValueListenableBuilder<bool>(
              valueListenable: _isDeleting,
              builder: (context, isDeleting, child) {
                return isDeleting
                    ? const CircularProgressIndicator()
                    : TextButton(
                        child: const Text(
                          'Eliminar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                          _isDeleting.value = true;
                          _controller
                              .removeMember(homeId!, userEmail!)
                              .then((_) {
                            _isDeleting.value = false;
                            Navigator.of(context).pop();
                          });
                        },
                      );
              },
            ),
          ],
        );
      },
    );
  }

  /*
  Home getHomeInCharge(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .firstWhere((home) => home.encargado == user);
  }

  List<Home> getHomeResident(User user) {
    return ref
        .watch(testingHomeInformationProvider)
        .where((home) => home.users.contains(user))
        .toList();
  }

  void updateUserRole(User user) {
    ref
        .watch(userInformationProvider.notifier)
        .updateUserRole(user.email as String);
  }


   */

  @override
  Widget build(BuildContext context) {
    //final usersInformation = getHomeInCharge(widget.userInformation).users;

    //final allusersInformation = ref.watch(userInformationProvider).toList();

    if (kDebugMode) {
      for (var user in usersInformation) {
        print('User: ${user.email}');
      }
    }

    return SafeArea(
      child: Scaffold(
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
                      'Mi hogar',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                        alignment: Alignment.topCenter,
                        onPressed: () {
                          _loadHouseInformation();
                        },
                        icon: const Icon(Icons.refresh, size: 32))
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
                          'En el siguiente apartado, puede administrar la lista de integrantes de tu hogar, asi como agregar nuevos.',
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
                const SizedBox(height: 46),
                Expanded(
                    child: FutureBuilder(
                  future: _loadHouseInformation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Show an error message if _loadPermissions completed with an error
                    } else if (usersInformation.isEmpty) {
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
                                  'Por el momento no hay integrantes en tu hogar.',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UsersList(
                            usersInformation: usersInformation,
                            showDeleteUserDialog: showDeleteUserDialog,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${usersInformation.length}/$totalUsers restante',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  },
                )),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        floatingActionButton: InvitationButton(
          onSubmit: _submitToInvitation,
        ),
      ),
    );
  }
}
