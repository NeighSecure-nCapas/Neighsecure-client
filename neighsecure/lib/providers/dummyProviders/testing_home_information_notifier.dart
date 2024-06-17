import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/dummy/home_dummy_data.dart';

import '../models/dummy/user_dummy_data.dart';
import '../models/entities/home.dart';
import '../models/entities/role.dart';
import '../models/entities/user.dart';

class TestingHomeInformationNotifier extends StateNotifier<List<Home>> {
  final StateNotifierProviderRef<TestingHomeInformationNotifier, List<Home>>
      ref;

  TestingHomeInformationNotifier(this.ref) : super(dummyHomes);

  void removeTestingHome(Home testingHome) {
    state = state.where((element) => element != testingHome).toList();
  }

  void addTestingHome(Home testingHome) {
    state = [...state, testingHome];
  }

  void updateTestingHome(Home testingHome) {
    state = state.map((home) {
      if (home == testingHome) {
        return testingHome;
      }
      return home;
    }).toList();
  }

  Future<void> addUserAndUpdateRoleAndHome(
      User user, Home home, String houseId) async {
    try {
      if (home.users.any((existingUser) => existingUser.email == user.email)) {
        throw Exception('El usuario ya está en la casa');
      }

      state = state.map((currentHome) {
        if (currentHome == home) {
          if (kDebugMode) {
            print('Before update: ${currentHome.users}');
          }
          currentHome =
              currentHome.copyWith(users: [...currentHome.users, user]);
          if (kDebugMode) {
            print('After update: ${currentHome.users}');
          }
        }
        return currentHome;
      }).toList();

      state = List.from(state);

      if (kDebugMode) {
        print('Here 1');
      }

      user = user.copyWith(homeId: houseId.toString());

      if (kDebugMode) {
        print('User after update: ${user.email}, ${user.homeId}');
      }
      Role updatedRole;

      if (user.roles.isNotEmpty) {
        String oldRole = user.roles.first.role.toString();
        String newRole;
        String newRoleId;

        if (oldRole == 'visitante') {
          newRole = 'residente';
          newRoleId = '3'; // id for 'residente'
        } else if (oldRole == 'residente') {
          newRole = 'visitante';
          newRoleId = '2'; // id for 'visitante'
        } else {
          throw Exception('Invalid role');
        }

        updatedRole = Role(
          id: newRoleId, // assign the new id based on the role
          role: newRole,
        );
        if (kDebugMode) {
          print('Old role: $oldRole, New role: $newRole');
        }
      } else {
        throw Exception('User has no roles');
      }

      user = user.copyWith(roles: [updatedRole], homeId: houseId);

      if (kDebugMode) {
        print('User after update: ${user.email}, ${user.homeId}');
      }

      int userIndex =
          dummyUsers.indexWhere((element) => element.email == user.email);
      if (userIndex != -1) {
        dummyUsers[userIndex] = user;
      }

      int homeIndex = dummyHomes.indexWhere((element) => element.id == houseId);
      if (homeIndex != -1) {
        Home updatedHome = dummyHomes[homeIndex]
            .copyWith(users: [...dummyHomes[homeIndex].users, user]);
        dummyHomes[homeIndex] = updatedHome;
      }

      state = state.map((h) {
        if (h == home) {
          return home.copyWith(
              users: home.users
                  .map((u) => u.email == user.email ? user : u)
                  .toList());
        }
        return h;
      }).toList();

      state = List.from(state);
      return Future.value();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to add user and update role and home: $e');
      }
      return Future.error(e);
    }
  }

  /*
  Future<void> addUserToHome(User user, Home home) async {
    try {
      state = state.map((currentHome) {
        if (currentHome == home) {
          // If the current home is the home where we want to add the user,
          // we add the user to the list of users of the home
          if (kDebugMode) {
            print('Before update: ${currentHome.users}');
          }
          currentHome =
              currentHome.copyWith(users: [...currentHome.users, user]);
          if (kDebugMode) {
            print('After update: ${currentHome.users}');
          }
        }
        // If the current home is not the home where we want to add the user,
        // we return it as is
        return currentHome;
      }).toList();

      if (kDebugMode) {
        print(
            'After update: ${state.firstWhere((element) => element == home).users}');
      }
      state = List.from(state);

      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateUserRoleAndHome(String email, String houseId) async {
    try {
      // Find the home that contains the user with the given email
      Home home = state
          .firstWhere((home) => home.users.any((user) => user.email == email));

      // Find the user in the home
      User user = home.users.firstWhere((user) => user.email == email);

      // Update the user's role and home
      Role updatedRole;
      if (user.roles.isNotEmpty) {
        String oldRole = user.roles.first.role.toString();
        String newRole;

        if (oldRole == 'visitante') {
          newRole = 'residente';
        } else if (oldRole == 'residente') {
          newRole = 'visitante';
        } else {
          throw Exception('Invalid role');
        }

        updatedRole = Role(
          id: user.roles.first.id, // assuming Role has an id property
          role: newRole,
        );
      } else {
        throw Exception('User has no roles');
      }

      User updatedUser = user.copyWith(roles: [updatedRole], homeId: houseId);

      // Update the user in the home
      home = home.copyWith(
          users: home.users
              .map((u) => u.email == email ? updatedUser : u)
              .toList());

      // Update the home in the state
      state = state.map((h) => h == home ? home : h).toList();

      if (kDebugMode) {
        print(
            'U After update: ${updatedUser.name.toString()}, ${updatedUser.hashCode.toString()}, ${updatedUser.roles.first.role.toString()}, ${updatedUser.homeId.toString()}');
      }

      return Future.value();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update user role and home: $e');
      }
      rethrow;
    }
  }
  */
}

final testingHomeInformationProvider =
    StateNotifierProvider<TestingHomeInformationNotifier, List<Home>>((ref) {
  return TestingHomeInformationNotifier(ref);
});
