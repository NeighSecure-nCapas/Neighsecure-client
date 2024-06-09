import 'package:neighsecure/models/dummy/user_dummy_data.dart';

import '../entities/home.dart';

List<Home> dummyHomes = [
  Home(
    id: '1',
    homeNumber: 5,
    address: 'Dummy Address 1',
    // Add dummy User objects as needed// Add dummy Permission objects as needed
    status: true,
    users: [
      dummyUsers[1],
      dummyUsers[3],
      dummyUsers[8],
    ],
    encargado: dummyUsers[0],
  ),
];
