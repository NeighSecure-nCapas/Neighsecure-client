import 'package:neighsecure/models/dummy/role_dummy_data.dart';
import 'package:neighsecure/models/dummy/token_dummy_data.dart';

import '../entities/user.dart';

List<User> dummyUsers = [
  User(
    id: '1',
    name: 'Dummy User 1',
    email: 'dummy1@email.com',
    phone: '+50312345678',
    roles: [
      dummyRoles[0],
    ],
    dui: 'dummy-dui-1',
    isActive: true,
    tokens: [
      dummyTokens[0],
    ],
    homeId: '1',
  ),
  User(
    id: '2',
    name: 'Dummy User 2',
    email: 'dummy2@email.com',
    phone: '+50323456789',
    roles: [
      dummyRoles[2],
    ],
    // Add dummy Role objects as needed
    dui: 'dummy-dui-2',
    isActive: false,
    // Add dummy Permission objects as needed
    tokens: [dummyTokens[1]],
    homeId: '1',
  ),
  User(
    id: '3',
    name: 'Dummy User 3',
    email: 'dummy3@email.com',
    phone: '+50334567890',
    roles: [
      dummyRoles[3],
    ],
    // Add dummy Role objects as needed
    dui: 'dummy-dui-3',
    isActive: true,
    // Add dummy Permission objects as needed
    tokens: [dummyTokens[2]], // Add dummy Token objects as needed
  ),
  User(
    id: '4',
    name: 'Dummy User 4',
    email: 'dummy4@email.com',
    phone: '+50345678901',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-4',
    isActive: true,
    tokens: [dummyTokens[3]],
    homeId: '1',
  ),
  User(
    id: '5',
    name: 'Dummy User 5',
    email: 'dummy5@email.com',
    phone: '+50356789012',
    roles: [
      dummyRoles[1],
    ],
    dui: 'dummy-dui-5',
    isActive: false,
    tokens: [dummyTokens[4]],
  ),
  User(
    id: '6',
    name: 'Dummy User 6',
    email: 'dummy6@email.com',
    phone: '+50367890123',
    roles: [
      dummyRoles[1],
    ],
    dui: 'dummy-dui-6',
    isActive: true,
    tokens: [dummyTokens[5]],
  ),
  User(
    id: '7',
    name: 'Dummy User 7',
    email: 'dummy7@email.com',
    phone: '+50378901234',
    roles: [
      dummyRoles[1],
    ],
    dui: 'dummy-dui-7',
    isActive: false,
    tokens: [dummyTokens[6]],
  ),
  User(
    id: '8',
    name: 'Dummy User 8',
    email: 'dummy8@email.com',
    phone: '+50389012345',
    roles: [
      dummyRoles[1],
    ],
    dui: 'dummy-dui-8',
    isActive: true,
    tokens: [dummyTokens[7]],
  ),
  User(
    id: '9',
    name: 'Dummy User 9',
    email: 'dummy9@email.com',
    phone: '+50390123456',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-9',
    isActive: true,
    tokens: [dummyTokens[8]],
    homeId: '1',
  ),
];
