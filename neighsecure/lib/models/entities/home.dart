import 'user.dart';
import 'permission.dart';

class Home {
  final String id;
  final int homeNumber;
  final String address;
  final User homeOwner;
  final List<User> homeMembers;
  final List<Permission> permissions;
  final bool status;
  final int membersNumber;

  Home({
    required this.id,
    required this.homeNumber,
    required this.address,
    required this.homeOwner,
    required this.homeMembers,
    required this.permissions,
    required this.status,
    required this.membersNumber,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json['id'],
      homeNumber: json['homeNumber'],
      address: json['address'],
      homeOwner: User.fromJson(json['homeOwner']),
      homeMembers: (json['homeMembers'] as List).map((i) => User.fromJson(i)).toList(),
      permissions: (json['permissions'] as List).map((i) => Permission.fromJson(i)).toList(),
      status: json['status'],
      membersNumber: json['membersNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeNumber': homeNumber,
      'address': address,
      'homeOwner': homeOwner.toJson(),
      'homeMembers': homeMembers.map((user) => user.toJson()).toList(),
      'permissions': permissions.map((permission) => permission.toJson()).toList(),
      'status': status,
      'membersNumber': membersNumber,
    };
  }
}