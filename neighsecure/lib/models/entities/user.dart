import 'home.dart';
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
  final List<String> entries;
  final Home home;

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
    this.entries = const [],
    required this.home,
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
      entries: (json['entries'] as List).map((i) => i.toString()).toList(),
      home: Home.fromJson(json['home']),
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
      'entries': entries,
      'home': home.toJson(),
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
    List<String>? entries,
    Home? home,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      roles: roles ?? this.roles,
      dui: dui ?? this.dui,
      isActive: isActive ?? this.isActive,
      permissions: permissions ?? this.permissions,
      tokens: tokens ?? this.tokens,
      entries: entries ?? this.entries,
      home: home ?? this.home,
    );
  }

}