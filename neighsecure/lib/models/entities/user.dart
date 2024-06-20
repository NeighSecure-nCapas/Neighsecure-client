import 'permission.dart';
import 'role.dart';
import 'toke.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final List<Role> roles;
  final String? dui;
  final String? homeId;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.roles,
    this.dui,
    this.homeId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      roles: (json['roles'] as List).map((i) => Role.fromJson(i)).toList(),
      dui: json['dui'],
      homeId: json['home'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'username': name,
      'email': email,
      'phoneNumer': phone ?? '',
      'roles': roles.map((role) => role.toJson()).toList(),
      'dui': dui ?? '',
      'homeId': homeId ?? '',
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<Role>? roles,
    String? dui,
    bool? isActive,
    List<Permission>? permissions,
    List<Token>? tokens,
    String? homeId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      roles: roles ?? this.roles,
      dui: dui ?? this.dui,
      homeId: homeId ?? this.homeId,
    );
  }
}
