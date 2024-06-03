class Terminal {
  final String id;
  final String entryType;

  Terminal({
    required this.id,
    required this.entryType,
  });

  factory Terminal.fromJson(Map<String, dynamic> json) {
    return Terminal(
      id: json['id'],
      entryType: json['entryType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entryType': entryType,
    };
  }
}
