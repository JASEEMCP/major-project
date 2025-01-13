import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefFile {
  final String fileName;
  PrefFile(this.fileName);

  ///Load physical data from storage
  Future<Map<String, dynamic>> load() async {
    final data = await const FlutterSecureStorage().read(key: fileName);

    return Map<String, dynamic>.from(jsonDecode(data ?? '{}'));
  }

  ///Save data into local storage
  Future<void> save(Map<String, dynamic> data) async {
    await const FlutterSecureStorage()
        .write(key: fileName, value: jsonEncode(data));
  }
}
