class Role {
  final String? id;
  final String? role;

  Role({
    this.id,
    this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['rolId'] as String? ?? '',
      role: json['rol'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rolId': id ?? '',
      'rol': role ?? '',
    };
  }
}
