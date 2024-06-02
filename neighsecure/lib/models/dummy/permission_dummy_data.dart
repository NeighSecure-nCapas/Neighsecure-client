import 'package:neighsecure/models/dummy/entry_dummy_data.dart';
import 'package:neighsecure/models/dummy/user_dummy_data.dart';
import '../entities/permission.dart';
import 'home_dummy_data.dart';
import 'key_dummy_data.dart';

List<Permission> dummyPermissions = [
  Permission(
    id: '1',
    type: 'dummy-type-1',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    status: true,
    valid: true,
    key: dummyKeys[3],
    generationDate: DateTime.now(),
    days: 'dummy-days-1',
    home: dummyHomes[2],
    user: dummyUsers[0],
    entries: dummyEntries,
  ),
  Permission(
    id: '2',
    type: 'dummy-type-2',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 2)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 2)),
    status: false,
    valid: true,
    key: dummyKeys[1],
    generationDate: DateTime.now(),
    days: 'dummy-days-2',
    home: dummyHomes[0],
    user: dummyUsers[1],
    entries: dummyEntries,
  ),
  Permission(
    id: '3',
    type: 'dummy-type-3',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 3)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 3)),
    status: true,
    valid: false,
    key: dummyKeys[2],
    generationDate: DateTime.now(),
    days: 'dummy-days-3',
    home: dummyHomes[3],
    user: dummyUsers[2],
    entries: dummyEntries,
  ),
];