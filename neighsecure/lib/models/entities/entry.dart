import 'terminal.dart';
import 'permission.dart';

class Entry {
  final String id;
  final DateTime entryDate;
  final Terminal terminal;
  final String? comment;

  Entry({
    required this.id,
    required this.entryDate,
    required this.terminal,
    this.comment,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      entryDate: DateTime.parse(json['entryDate']),
      terminal: Terminal.fromJson(json['terminal']),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entryDate': entryDate.toIso8601String(),
      'terminal': terminal.toJson(),
      'comment': comment,
    };
  }
}