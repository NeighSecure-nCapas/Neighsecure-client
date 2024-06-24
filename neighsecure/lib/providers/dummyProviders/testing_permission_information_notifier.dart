import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/models/dummy/permission_dummy_data.dart';
import 'package:neighsecure/models/entities/permission.dart';

import '../../models/entities/user.dart';

class PermissionInformationNotifier extends StateNotifier<List<Permission>> {
  final StateNotifierProviderRef<PermissionInformationNotifier,
      List<Permission>> ref;

  PermissionInformationNotifier(this.ref) : super(dummyPermissions);

  void removePermission(Permission permission) {
    state = state.where((element) => element != permission).toList();
  }

  void addPermission(Permission permission) {
    state = [...state, permission];
  }

  void updateUserRedeem(User user) {
    state = state.map((permission) {
      if (permission.user == user) {
        // If the permission belongs to the user, update the status to true
        return permission.copyWith(status: true);
      }
      // If the permission does not belong to the user, return it as is
      return permission;
    }).toList();
  }

  void updateUserDeny(User user) {
    state = state.map((permission) {
      if (permission.user == user) {
        // If the permission belongs to the user, update the status to false
        return permission.copyWith(status: false);
      }
      // If the permission does not belong to the user, return it as is
      return permission;
    }).toList();
  }

  void updateUserPermission(User user) {
    state = state.map((permission) {
      if (permission.user == user) {
        // If the permission belongs to the user, update the status to true
        return permission.copyWith(status: true);
      }
      // If the permission does not belong to the user, return it as is
      return permission;
    }).toList();
  }
}

final permissionInformationProvider =
    StateNotifierProvider<PermissionInformationNotifier, List<Permission>>(
        (ref) {
  return PermissionInformationNotifier(ref);
});
