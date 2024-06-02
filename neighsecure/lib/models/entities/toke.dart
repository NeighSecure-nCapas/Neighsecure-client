import 'user.dart';

class Token {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool active;
  final User user;

  Token({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.active,
    required this.user,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      active: json['active'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'active': active,
      'user': user.toJson(),
    };
  }
}