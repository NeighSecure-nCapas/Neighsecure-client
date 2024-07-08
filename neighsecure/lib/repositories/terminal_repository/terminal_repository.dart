import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:neighsecure/models/entities/terminal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerminalRepository {
  Future<void> saveTerminals(List<dynamic> terminals) async {
    //Cast every terminal to a terminal object
    List<Terminal> terminalList =
        terminals.map((terminal) => Terminal.fromJson(terminal)).toList();

    if (kDebugMode) {
      for (var element in terminalList) {
        print(element.toJson());
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var terminal in terminalList) {
      // Convert each terminal to a JSON string
      String terminalString = jsonEncode(terminal.toJson());
      // Save each terminal under a unique key (the terminal's ID)
      await prefs.setString('terminal_${terminal.id}', terminalString);
    }
  }

  Future<List<Terminal>?> retrieveTerminals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get all keys
    Set<String> keys = prefs.getKeys();
    // Filter keys that start with 'terminal_'
    Iterable<String> terminalKeys =
        keys.where((String key) => key.startsWith('terminal_'));
    // Retrieve and decode each terminal
    List<Terminal> terminals = [];
    for (String key in terminalKeys) {
      String? terminalString = prefs.getString(key);
      if (terminalString != null) {
        terminals.add(Terminal.fromJson(jsonDecode(terminalString)));
      }
    }
    return terminals;
  }

  Future<void> saveSelectedTerminal(Terminal selectedTerminal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String terminalString = jsonEncode(selectedTerminal);
    await prefs.setString('selectedTerminal', terminalString);
  }

  Future<void> updateTerminals(List<dynamic> terminals) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String terminalsString = jsonEncode(terminals);
    await prefs.setString('terminals', terminalsString);
  }

  Future<void> deleteTerminals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('terminals');
  }
}
