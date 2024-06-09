import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../models/dummy/user_dummy_data.dart';
import '../models/entities/home.dart';
import '../models/entities/role.dart';

class UserInformationNotifier extends StateNotifier<List<User>> {
  final StateNotifierProviderRef<UserInformationNotifier, List<User>> ref;

  UserInformationNotifier(this.ref) : super(dummyUsers);

  void removeUser(User user) {
    state = state.where((element) => element != user).toList();
  }

  /*
  void updateUserRedeem(User user) {
    state = state.map((element) {
      if (element == user) {
        List<Permission> updatedPermissions = element.permissions.map((perm) {
          return perm.copyWith(status: true);
        }).toList();
        return user.copyWith(permissions: updatedPermissions);
      }
      return element;
    }).toList();
  }

   */

  Future<void> updateUserRole(String email) async {
    try {
      int index = state.indexWhere((element) => element.email == email);
      if (index == -1) {
        throw Exception('User not found');
      }

      Role updatedRole; // Define updatedRole here

      if (state[index].roles.isNotEmpty) {
        String oldRole = state[index].roles.first.role.toString();
        String newRole;

        if (oldRole == 'visitante') {
          newRole = 'residente';
        } else if (oldRole == 'residente') {
          newRole = 'visitante';
        } else {
          throw Exception('Invalid role');
        }

        // Assign a new role to updatedRole
        updatedRole = Role(
          id: state[index].roles.first.id, // assuming Role has an id property
          role: newRole,
        );
      } else {
        throw Exception('User has no roles');
      }

      User updatedUser = state[index].copyWith(roles: [updatedRole]);
      state[index] = updatedUser;

      if (kDebugMode) {
        print(
            'After update: $updatedUser, ${updatedUser.hashCode}, ${updatedUser.roles.first.role}');
      }

      // Directly update the state with the updated list of users
      state = List.from(state);

      return Future.value();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update user role: $e');
      }
      rethrow;
    }
  }

  Future<void> updateUserRoleAndHome(String email, String houseId) async {
    try {
      int index = state.indexWhere((element) => element.email == email);
      if (index == -1) {
        throw Exception('User not found');
      }

      Role updatedRole;

      if (state[index].roles.isNotEmpty) {
        String oldRole = state[index].roles.first.role.toString();
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
      } // Define updatedRole here

      User updatedUser =
          state[index].copyWith(roles: [updatedRole], homeId: houseId);
      state[index] = updatedUser;

      if (kDebugMode) {
        print(
            'U After update: ${updatedUser.name.toString()}, ${updatedUser.hashCode.toString()}, ${updatedUser.roles.first.role.toString()}, ${updatedUser.homeId.toString()}');
      }

      // Directly update the state with the updated list of users
      state = List.from(state);

      return Future.value();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update user role and home: $e');
      }
      rethrow;
    }
  }

  Future<void> updateUserHome(String email, Home newHome) async {
    int index = state.indexWhere((element) => element.email == email);
    if (index != -1) {
      User updatedUser = state[index].copyWith(homeId: newHome.id);
      state[index] = updatedUser;

      if (kDebugMode) {
        print(' U After update: $updatedUser, ${updatedUser.hashCode}');
      }
    }

    // Directly update the state with the updated list of users
    state = List.from(state);

    return Future.value();
  }

  void addUser(User user) {
    int index = state.indexWhere((element) => element.id == user.id);
    if (index != -1) {
      // If the user exists, replace the existing user with the new user
      state[index] = user;
    } else {
      // If the user doesn't exist, add the new user to the state
      state = [...state, user];
    }
    state = state;
  }
}

final userInformationProvider =
    StateNotifierProvider<UserInformationNotifier, List<User>>((ref) {
  return UserInformationNotifier(ref);
});
