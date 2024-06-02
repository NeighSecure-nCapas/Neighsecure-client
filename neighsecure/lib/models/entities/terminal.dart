import 'entry.dart';

class Terminal {
  final String id;
  final String entryType;
  final List<Entry> entries;

  Terminal({
    required this.id,
    required this.entryType,
    required this.entries,
  });

  factory Terminal.fromJson(Map<String, dynamic> json) {
    return Terminal(
      id: json['id'],
      entryType: json['entryType'],
      entries: (json['entries'] as List).map((i) => Entry.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entryType': entryType,
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }
}