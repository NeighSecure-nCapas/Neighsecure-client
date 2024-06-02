import 'package:neighsecure/models/dummy/entry_dummy_data.dart';
import 'package:neighsecure/models/dummy/user_dummy_data.dart';
import '../entities/permission.dart';
import 'home_dummy_data.dart';
import 'key_dummy_data.dart';

List<Permission> dummyPermissions = [
  Permission(
    id: '1',
    type: 'single',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    status: true,
    valid: true,
    key: dummyKeys[2],
    generationDate: DateTime.now(),
    days: 'Martes',
    entries: [dummyEntries[0]],
  ),
  Permission(
    id: '2',
    type: 'single',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 2)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 2)),
    status: false,
    valid: true,
    key: dummyKeys[1],
    generationDate: DateTime.now(),
    days: 'Lunes',
    entries: [dummyEntries[1]],
  ),
  Permission(
    id: '3',
    type: 'multiple',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 3)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 3)),
    status: true,
    valid: false,
    key: dummyKeys[2],
    generationDate: DateTime.now(),
    days: 'Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo',
    entries: [dummyEntries[1]],
  ),
];