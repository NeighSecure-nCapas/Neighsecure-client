import 'package:neighsecure/models/dummy/user_dummy_data.dart';
import 'package:neighsecure/models/entities/user.dart';


import '../entities/toke.dart';

List<Token> dummyTokens = [
  Token(
    id: '1',
    content: 'dummyContent1',
    timestamp: DateTime.now(),
    active: true,
  ),
  Token(
    id: '2',
    content: 'dummyContent2',
    timestamp: DateTime.now(),
    active: false,
  ),
  Token(
    id: '3',
    content: 'dummyContent3',
    timestamp: DateTime.now(),
    active: true,
  ),
];