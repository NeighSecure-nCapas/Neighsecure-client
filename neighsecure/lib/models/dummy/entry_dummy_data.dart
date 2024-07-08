import 'package:neighsecure/models/dummy/terminal_dummy_data.dart';
import 'package:neighsecure/models/entities/entry.dart';

List<Entry> dummyEntries = [
  Entry(
    id: '1',
    entryDate: DateTime.now(),
    terminal: dummyTerminals[0],
    // Assuming dummyPermissions is a list of Permission objects
    comment: null,
  ),
  Entry(
    id: '2',
    entryDate: DateTime.now().add(const Duration(days: 1)),
    terminal: dummyTerminals[1],
    // Assuming dummyPermissions is a list of Permission objects
    comment: null,
  ),
  Entry(
    id: '3',
    entryDate: DateTime.now().add(const Duration(days: 2)),
    terminal: dummyTerminals[1],
    // Assuming dummyPermissions is a list of Permission objects
    comment: 'Dummy Comment 3',
  ),
];
