import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/entities/user.dart';

import '../models/dummy/user_dummy_data.dart';
import '../models/entities/permission.dart';
import '../models/entities/role.dart';

class UserInformationNotifier extends StateNotifier<List<User>> {
  UserInformationNotifier() : super([...dummyUsers]);

  void removeUser(User user) {
    state = state.where((element) => element != user).toList();
  }

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

  void updateUserRole(User user, String oldRole, String newRole) {
    state = state.map((element) {
      if (element == user) {
        List<Role> updatedRoles = element.roles.map((role) {
          if (role.role == oldRole) {
            return Role(
              id: 'newId', // replace with appropriate value
              role: newRole,
              // replace with appropriate value
            );
          }
          return role;
        }).toList();
        return user.copyWith(roles: updatedRoles);
      }
      return element;
    }).toList();
  }

  void addUser(User user) {
    state = [...state, user];
  }
}

final userInformationProvider =
    StateNotifierProvider<UserInformationNotifier, List<User>>((ref) {
  return UserInformationNotifier();
});
