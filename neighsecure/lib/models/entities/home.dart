class Home {
  final String id;
  final int homeNumber;
  final String address;
  final bool status;
  final int membersNumber;

  Home({
    required this.id,
    required this.homeNumber,
    required this.address,
    required this.status,
    required this.membersNumber,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json['id'],
      homeNumber: json['homeNumber'],
      address: json['address'],
      status: json['status'],
      membersNumber: json['membersNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeNumber': homeNumber,
      'address': address,
      'status': status,
      'membersNumber': membersNumber,
    };
  }
}
