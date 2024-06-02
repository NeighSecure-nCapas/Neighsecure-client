import 'package:neighsecure/models/dummy/permission_dummy_data.dart';
import 'package:neighsecure/models/dummy/role_dummy_data.dart';
import 'package:neighsecure/models/dummy/token_dummy_data.dart';

import '../entities/user.dart';
import 'home_dummy_data.dart';


List<User> dummyUsers = [
  User(
    id: '1',
    name: 'Dummy User 1',
    email: 'dummy1@email.com',
    phone: '1234567890',
    roles: [
      dummyRoles[0],
      dummyRoles[1],
    ],
    dui: 'dummy-dui-1',
    isActive: true,
    permissions: [
      dummyPermissions[0],
    ],
    tokens: [
      dummyTokens[0],
    ],
      home: dummyHomes[0],
      entries: {
        '2024-04-25 10:00 am',
        '2024-04-25 11:00 am',
        '2024-04-25 12:00 pm',
        '2024-04-25 13:00 pm',
        '2024-04-25 14:00 pm',
        '2024-04-25 15:00 pm',
        '2024-04-25 16:00 pm',
        '2024-04-25 17:00 pm',
        '2024-04-25 18:00 pm',
      }.toList()// Add dummy Token objects as needed
  ),
  User(
    id: '2',
    name: 'Dummy User 2',
    email: 'dummy2@email.com',
    phone: '0987654321',
    roles: [
      dummyRoles[2],
      dummyRoles[3],
    ], // Add dummy Role objects as needed
    dui: 'dummy-dui-2',
    isActive: false,
    permissions: [
      dummyPermissions[0],
      dummyPermissions[1],
    ], // Add dummy Permission objects as needed
    tokens: [
      dummyTokens[1]
    ],
    home: dummyHomes[1],
      entries: {
        '2024-04-25 10:00 am',
        '2024-04-25 11:00 am',
        '2024-04-25 12:00 pm',
        '2024-04-25 13:00 pm',
        '2024-04-25 14:00 pm',
        '2024-04-25 15:00 pm',
        '2024-04-25 16:00 pm',
        '2024-04-25 17:00 pm',
        '2024-04-25 18:00 pm',
      }.toList()// Add dummy Token objects as needed
  ),
  User(
    id: '3',
    name: 'Dummy User 3',
    email: 'dummy3@email.com',
    phone: '1122334455',
    roles: [
      dummyRoles[0],
      dummyRoles[1],
    ], // Add dummy Role objects as needed
    dui: 'dummy-dui-3',
    isActive: true,
    permissions: [
      dummyPermissions[1],
    ], // Add dummy Permission objects as needed
    tokens: [
      dummyTokens[2]
    ],
    home: dummyHomes[2],
    entries: {
      '2024-04-25 10:00 am',
      '2024-04-25 11:00 am',
      '2024-04-25 12:00 pm',
      '2024-04-25 13:00 pm',
      '2024-04-25 14:00 pm',
      '2024-04-25 15:00 pm',
      '2024-04-25 16:00 pm',
      '2024-04-25 17:00 pm',
      '2024-04-25 18:00 pm',
    }.toList(),// Add dummy Token objects as needed
  ),
];