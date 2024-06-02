import 'permission.dart';
import 'role.dart';
import 'toke.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Role> roles;
  final String dui;
  final bool isActive;
  final List<Permission> permissions;
  final List<Token> tokens;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.roles,
    required this.dui,
    required this.isActive,
    required this.permissions,
    required this.tokens,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      roles: (json['roles'] as List).map((i) => Role.fromJson(i)).toList(),
      dui: json['dui'],
      isActive: json['isActive'],
      permissions: (json['permissions'] as List).map((i) => Permission.fromJson(i)).toList(),
      tokens: (json['tokens'] as List).map((i) => Token.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'roles': roles.map((role) => role.toJson()).toList(),
      'dui': dui,
      'isActive': isActive,
      'permissions': permissions.map((permission) => permission.toJson()).toList(),
      'tokens': tokens.map((token) => token.toJson()).toList(),
    };
  }
}