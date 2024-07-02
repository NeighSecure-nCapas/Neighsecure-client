import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/permissions.dart';

class PermissionRepository {
  Future<void> savePermissions(List<Permissions> permissions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String permissionsString = jsonEncode(
        permissions.map((permission) => permission.toJson()).toList());
    await prefs.setString('permissions', permissionsString);
  }

  Future<List<Permissions>?> retrievePermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? permissionsString = prefs.getString('permissions');

    if (kDebugMode) {
      print('Elementos de permisos:');
      print(permissionsString);
    }

    if (permissionsString != null) {
      List<dynamic> permissionsJson = jsonDecode(permissionsString);
      return permissionsJson
          .map((permission) => Permissions.fromJson(permission))
          .toList();
    }
    return [];
  }

  Future<void> savePermissionsToManage(List<Permissions> permissions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String permissionsString = jsonEncode(
        permissions.map((permission) => permission.toJson()).toList());
    await prefs.setString('permissionsToManage', permissionsString);
  }

  Future<List<Permissions>?> retrievePermissionsToManage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? permissionsString = prefs.getString('permissionsToManage');

    if (kDebugMode) {
      print('Elementos de permisos a gestionar:');
      print('$permissionsString\n\n');
    }

    if (permissionsString != null) {
      List<dynamic> permissionsJson = jsonDecode(permissionsString);
      return permissionsJson
          .map((permission) => Permissions.fromJson(permission))
          .toList();
    }
    return [];
  }

  Future<Permissions> saveDetails(Permissions permission) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('permission', jsonEncode(permission.toJson()));
    return permission;
  }

  Future<Permissions?> retrieveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? permissionString = prefs.getString('permission');
    if (permissionString != null) {
      if (kDebugMode) {
        print('Permisos detalles: $permissionString');
      }
      return Permissions.fromJson(jsonDecode(permissionString));
    }
    return null;
  }
}
