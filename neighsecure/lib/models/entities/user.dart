import 'role.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final List<Role>? roles;
  final String? dui;
  final String? homeId;
  final String? homeNumber;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.dui,
    this.homeId,
    this.homeNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'] ?? json['id'] ?? '',
      name: json['username'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phoneNumber'] ?? json['phone'] ?? '',
      roles: json['roles'] != null
          ? (json['roles'] as List).map((role) => Role.fromJson(role)).toList()
          : [],
      dui: json['dui'] ?? '',
      homeId: json['homeId'] ?? '',
      homeNumber: json['homeNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id ?? '',
      'username': name ?? '',
      'email': email ?? '',
      'phoneNumber': phone ?? '',
      'roles': roles?.map((role) => role.toJson()).toList() ?? [],
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
