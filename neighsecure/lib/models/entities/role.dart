import 'user.dart';

class Role {
  final String id;
  final String role;
  final List<User> users;

  Role({
    required this.id,
    required this.role,
    required this.users,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      role: json['role'],
      users: (json['users'] as List).map((i) => User.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'users': users.map((user) => user.toJson()).toList(),
    };
  }
}