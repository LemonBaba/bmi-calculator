import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bmi_entry.dart';

class LocalStorageService {
  static const _key = 'bmi_entries';

  static Future<void> saveEntry(BmiEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getEntries();
    list.add(entry);
    final encoded = jsonEncode(list.map((e) => e.toMap()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<List<BmiEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => BmiEntry.fromMap(e)).toList();
  }
}