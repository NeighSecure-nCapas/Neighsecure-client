import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/key.dart';

class KeyRepository {
  Future<void> saveKey(Map<String, dynamic> keyJson) async {
    Key key = Key.fromJson(keyJson);
    if (foundation.kDebugMode) {
      print(key.toJson());
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('key', jsonEncode(key.toJson()));
  }

  Future<Key?> retrieveKeyLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? keyString = prefs.getString('key');

    if (keyString != null) {
      return Key.fromJson(jsonDecode(keyString));
    }
    return null;
  }
}
