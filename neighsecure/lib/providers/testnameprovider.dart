import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameVisitorProvider extends StateNotifier<String> {
  NameVisitorProvider() : super('');

  void updateName(String name) {
    state = name;
  }
}

final nameProvider = StateNotifierProvider<NameVisitorProvider, String>((ref) {
  return NameVisitorProvider();
});
