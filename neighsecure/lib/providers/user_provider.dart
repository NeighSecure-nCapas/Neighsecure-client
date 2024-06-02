import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dummy/user_dummy_data.dart';

final userProvider = Provider((ref) {
  return dummyUsers;
});