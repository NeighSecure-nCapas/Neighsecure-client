import 'package:neighsecure/models/dummy/user_dummy_data.dart';

import '../entities/role.dart';

List<Role> dummyRoles = [
  Role(
    id: '1',
    role: 'encargado',
    users: dummyUsers, // Assuming dummyUsers is a list of User objects
  ),
  Role(
    id: '2',
    role: 'visitante',
    users: dummyUsers, // Assuming dummyUsers is a list of User objects
  ),
  Role(
    id: '3',
    role: 'residente',
    users: dummyUsers, // Assuming dummyUsers is a list of User objects
  ),
  Role(
    id: '4',
    role: 'vigilante',
    users: dummyUsers, // Assuming dummyUsers is a list of User objects
  ),
];