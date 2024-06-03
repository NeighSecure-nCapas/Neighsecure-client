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
      }.toList() // Add dummy Token objects as needed
      ),
  User(
      id: '2',
      name: 'Dummy User 2',
      email: 'dummy2@email.com',
      phone: '0987654321',
      roles: [
        dummyRoles[1],
      ], // Add dummy Role objects as needed
      dui: 'dummy-dui-2',
      isActive: false,
      permissions: [
        dummyPermissions[1],
      ], // Add dummy Permission objects as needed
      tokens: [dummyTokens[1]],
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
      }.toList() // Add dummy Token objects as needed
      ),
  User(
    id: '3',
    name: 'Dummy User 3',
    email: 'dummy3@email.com',
    phone: '1122334455',
    roles: [
      dummyRoles[3],
    ], // Add dummy Role objects as needed
    dui: 'dummy-dui-3',
    isActive: true,
    permissions: [
      dummyPermissions[1],
    ], // Add dummy Permission objects as needed
    tokens: [dummyTokens[2]],
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
    }.toList(), // Add dummy Token objects as needed
  ),
  User(
    id: '4',
    name: 'Dummy User 4',
    email: 'dummy4@email.com',
    phone: '2233445566',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-4',
    isActive: true,
    permissions: [
      dummyPermissions[0],
    ],
    tokens: [dummyTokens[0]],
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
    }.toList(),
  ),
  User(
    id: '5',
    name: 'Dummy User 5',
    email: 'dummy5@email.com',
    phone: '3344556677',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-5',
    isActive: false,
    permissions: [
      dummyPermissions[1],
    ],
    tokens: [dummyTokens[1]],
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
    }.toList(),
  ),
  User(
    id: '6',
    name: 'Dummy User 6',
    email: 'dummy6@email.com',
    phone: '4455667788',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-6',
    isActive: true,
    permissions: [
      dummyPermissions[0],
    ],
    tokens: [dummyTokens[0]],
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
    }.toList(),
  ),
  User(
    id: '7',
    name: 'Dummy User 7',
    email: 'dummy7@email.com',
    phone: '5566778899',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-7',
    isActive: false,
    permissions: [
      dummyPermissions[1],
    ],
    tokens: [dummyTokens[1]],
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
    }.toList(),
  ),
  User(
    id: '8',
    name: 'Dummy User 8',
    email: 'dummy8@email.com',
    phone: '6677889900',
    roles: [
      dummyRoles[1],
    ],
    dui: 'dummy-dui-8',
    isActive: true,
    permissions: [
      dummyPermissions[0],
    ],
    tokens: [dummyTokens[0]],
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
    }.toList(),
  ),
  User(
    id: '9',
    name: 'Dummy User 9',
    email: 'dummy9@email.com',
    phone: '7788990011',
    roles: [
      dummyRoles[2],
    ],
    dui: 'dummy-dui-9',
    isActive: false,
    permissions: [
      dummyPermissions[1],
    ],
    tokens: [dummyTokens[1]],
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
    }.toList(),
  ),
];
