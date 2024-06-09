import 'package:neighsecure/models/entities/key.dart';

List<Key> dummyKeys = [
  Key(
    id: '1',
    generationDate: DateTime.now(),
    generationTime: DateTime.now(),
    generationDay: 'Monday',
  ),
  Key(
    id: '2',
    generationDate: DateTime.now().add(const Duration(days: 1)),
    generationTime: DateTime.now().add(const Duration(hours: 1)),
    generationDay: 'Tuesday',
  ),
  Key(
    id: '3',
    generationDate: DateTime.now().add(const Duration(days: 2)),
    generationTime: DateTime.now().add(const Duration(hours: 2)),
    generationDay: 'Wednesday',
  ),
];
