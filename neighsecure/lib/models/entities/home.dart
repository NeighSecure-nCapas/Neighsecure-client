import 'package:neighsecure/models/entities/user.dart';

class Home {
  final String id;
  final int homeNumber;
  final String address;
  final bool status;
  final List<User> users;
  final User encargado;

  Home({
    required this.id,
    required this.homeNumber,
    required this.address,
    required this.status,
    required this.users,
    required this.encargado,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json['id'],
      homeNumber: json['homeNumber'],
      address: json['address'],
      status: json['status'],
      users: (json['users'] as List).map((i) => User.fromJson(i)).toList(),
      encargado: User.fromJson(json['encargado']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeNumber': homeNumber,
      'address': address,
      'status': status,
      'users': users.map((user) => user.toJson()).toList(),
      'encargado': encargado.toJson(),
    };
  }

  Home copyWith({
    String? id,
    int? homeNumber,
    String? address,
    bool? status,
    List<User>? users,
    User? encargado,
  }) {
    return Home(
      id: id ?? this.id,
      homeNumber: homeNumber ?? this.homeNumber,
      address: address ?? this.address,
      status: status ?? this.status,
      users: users ?? this.users,
      encargado: encargado ?? this.encargado,
    );
  }
}
