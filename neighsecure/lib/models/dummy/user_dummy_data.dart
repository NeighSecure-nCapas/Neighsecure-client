import 'package:neighsecure/models/dummy/permission_dummy_data.dart';
import 'package:neighsecure/models/dummy/role_dummy_data.dart';

import '../entities/user.dart';


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
    tokens: [], // Add dummy Token objects as needed
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
    tokens: [], // Add dummy Token objects as needed
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
    tokens: [], // Add dummy Token objects as needed
  ),
];