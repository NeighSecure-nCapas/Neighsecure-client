class Key {
  final String id;
  final DateTime generationDate;
  final DateTime generationTime;
  final String generationDay;

  Key({
    required this.id,
    required this.generationDate,
    required this.generationTime,
    required this.generationDay,
  });

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(
      id: json['keyId'],
      generationDate: DateTime.parse(json['generationDate']),
      generationTime: DateTime.parse(json['generationTime']),
      generationDay: json['generationDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyId': id,
      'generationDate': generationDate.toIso8601String(),
      'generationTime': generationTime.toIso8601String(),
      'generationDay': generationDay,
    };
  }
}
