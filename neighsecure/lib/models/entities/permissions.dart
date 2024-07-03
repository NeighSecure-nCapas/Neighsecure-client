import 'package:neighsecure/models/entities/user.dart';

class Permissions {
  final String id;
  final String type;

  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  final String generationDate;

  final List<String> days;

  final String homeId;
  final String homeNumber;
  final String address;

  final String userId;

  final bool? status;
  final bool isValid;

  final List<String> entries;

  final User userAssociated;

  final User userAuth;

  Permissions({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.generationDate,
    required this.days,
    required this.homeId,
    required this.homeNumber,
    required this.address,
    required this.userId,
    required this.status,
    required this.isValid,
    required this.entries,
    required this.userAssociated,
    required this.userAuth,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      generationDate: json['generationDate'] ?? '',
      days: List<String>.from(json['days'].split(',')),
      homeId: json['homeId'] ?? '',
      homeNumber: json['homeNumber'].toString() ?? '',
      address: json['address'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'],
      isValid: json['valid'] ?? false,
      entries: List<String>.from((json['entries'] ?? '').split(',')),
      userAssociated: User.fromJson(json['userAssociated'] ?? {}),
      userAuth: User.fromJson(json['userAuth'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'generationDate': generationDate,
      'days': days.join(','),
      'homeId': homeId,
      'userId': userId,
      'status': status,
      'valid': isValid,
      'entries': entries.join(','),
      'userAssociated': userAssociated.toJson(),
      'userAuth': userAuth.toJson(),
    };
  }
}
