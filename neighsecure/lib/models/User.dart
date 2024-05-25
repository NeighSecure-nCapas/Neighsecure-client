class User {
  final String name;
  final String role;
  final String email;
  final String? tipoOfTicket;
  final String? redeem;
  final String? inviteBy;
  final String? entryhours;

  User({
    required this.name,
    required this.role,
    required this.email,
    this.tipoOfTicket,
    this.redeem,
    this.inviteBy,
    this.entryhours,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      role: json['role'],
      email: json['email'],
      tipoOfTicket: json['tipoOfTicket'],
      redeem: json['redeem'],
      inviteBy: json['inviteBy'],
      entryhours: json['entryhours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'email': email,
      'tipoOfTicket': tipoOfTicket,
      'redeem': redeem,
      'inviteBy': inviteBy,
      'entryhours': entryhours,
    };
  }
}