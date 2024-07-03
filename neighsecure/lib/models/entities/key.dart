class Key {
  final String id;
  final String generationDate;
  final String generationTime;
  final String generationDay;

  Key({
    required this.id,
    required this.generationDate,
    required this.generationTime,
    required this.generationDay,
  });

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(
      id: json['keyId'] ?? '',
      generationDate: json['generationDate'] ?? '',
      generationTime: json['generationTime'] ?? '',
      generationDay: json['generationDay'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyId': id,
      'generationDate': generationDate,
      'generationTime': generationTime,
      'generationDay': generationDay,
    };
  }
}
