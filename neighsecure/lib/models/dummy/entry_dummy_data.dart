import 'package:neighsecure/models/dummy/terminal_dummy_data.dart';
import 'package:neighsecure/models/entities/entry.dart';
import 'package:neighsecure/models/dummy/permission_dummy_data.dart';

List<Entry> dummyEntries = [
  Entry(
    id: '1',
    entryDate: DateTime.now(),
    terminal: dummyTerminals[0], // Assuming dummyTerminals is a list of Terminal objects
    permission: dummyPermissions[0], // Assuming dummyPermissions is a list of Permission objects
    comment: 'Dummy Comment 1',
  ),
  Entry(
    id: '2',
    entryDate: DateTime.now().add(Duration(days: 1)),
    terminal: dummyTerminals[1], // Assuming dummyTerminals is a list of Terminal objects
    permission: dummyPermissions[1], // Assuming dummyPermissions is a list of Permission objects
    comment: 'Dummy Comment 2',
  ),
  Entry(
    id: '3',
    entryDate: DateTime.now().add(Duration(days: 2)),
    terminal: dummyTerminals[2], // Assuming dummyTerminals is a list of Terminal objects
    permission: dummyPermissions[2], // Assuming dummyPermissions is a list of Permission objects
    comment: 'Dummy Comment 3',
  ),
];