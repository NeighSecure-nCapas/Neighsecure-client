import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingVisitorsProvider extends StateNotifier<List<Map<String, String>>> {
  PendingVisitorsProvider() : super([]);

  void updatePendingVisitors(List<Map<String, String>> visitors) {
    state = visitors;
  }
}

final pendingVisitorsProvider = StateNotifierProvider<PendingVisitorsProvider, List<Map<String, String>>>((ref) {
  return PendingVisitorsProvider();
});