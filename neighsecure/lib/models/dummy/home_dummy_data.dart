import 'package:neighsecure/models/dummy/permission_dummy_data.dart';
import 'package:neighsecure/models/dummy/user_dummy_data.dart';

import '../entities/home.dart';

List<Home> dummyHomes = [
  Home(
    id: '1',
    homeNumber: 1,
    address: 'Dummy Address 1', // Add dummy User objects as needed// Add dummy Permission objects as needed
    status: true,
    membersNumber: 2,
  ),
  Home(
    id: '2',
    homeNumber: 2,
    address: 'Dummy Address 2',// Add dummy User objects as needed// Add dummy Permission objects as needed
    status: false,
    membersNumber: 2,
  ),
  Home(
    id: '3',
    homeNumber: 3,
    address: 'Dummy Address 3', // Add dummy User objects as needed
    // Add dummy Permission objects as needed
    status: true,
    membersNumber: 1,
  ),
];
