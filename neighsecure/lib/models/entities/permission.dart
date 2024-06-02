import 'key.dart';
import 'home.dart';
import 'user.dart';
import 'entry.dart';

class Permission {
  final String id;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final bool status;
  final bool valid;
  final Key key;
  final DateTime generationDate;
  final String days;
  final Home home;
  final User user;
  final List<Entry> entries;

  Permission({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.valid,
    required this.key,
    required this.generationDate,
    required this.days,
    required this.home,
    required this.user,
    required this.entries,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: json['status'],
      valid: json['valid'],
      key: Key.fromJson(json['key']),
      generationDate: DateTime.parse(json['generationDate']),
      days: json['days'],
      home: Home.fromJson(json['home']),
      user: User.fromJson(json['user']),
      entries: (json['entries'] as List).map((i) => Entry.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
      'valid': valid,
      'key': key.toJson(),
      'generationDate': generationDate.toIso8601String(),
      'days': days,
      'home': home.toJson(),
      'user': user.toJson(),
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }
}