import 'package:neighsecure/models/entities/terminal.dart';
import 'package:neighsecure/models/dummy/entry_dummy_data.dart';

List<Terminal> dummyTerminals = [
  Terminal(
    id: '1',
    entryType: 'Type 1',
    entries: [dummyEntries[0], dummyEntries[1]], // Assuming dummyEntries is a list of Entry objects
  ),
  Terminal(
    id: '2',
    entryType: 'Type 2',
    entries: [dummyEntries[2]], // Assuming dummyEntries is a list of Entry objects
  ),
];