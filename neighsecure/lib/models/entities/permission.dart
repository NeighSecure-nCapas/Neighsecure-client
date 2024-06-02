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
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }

  Permission copyWith({
    String? id,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startTime,
    DateTime? endTime,
    bool? status,
    bool? valid,
    Key? key,
    DateTime? generationDate,
    String? days,
    List<Entry>? entries,
  }) {
    return Permission(
      id: id ?? this.id,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      valid: valid ?? this.valid,
      key: key ?? this.key,
      generationDate: generationDate ?? this.generationDate,
      days: days ?? this.days,
      entries: entries ?? this.entries,
    );
  }
}
