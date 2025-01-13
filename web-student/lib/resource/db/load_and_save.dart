// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:app/resource/db/pref_file.dart';


mixin LoadAndSaveMixin {
  late final _file = PrefFile(fileName);

  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> data);

  ///Load data
  Future<void> load() async {
    final dataMap = await _file.load();
    try {
      copyFromJson(dataMap);
    } on Exception catch (e) {
      debugPrint('Error to load data: $e');
    }
  }

  ///Save data
  Future<void> save() async {
    try {
      await _file.save(toJson());
      debugPrint('Token Updated...!');
    } on Exception catch (e) {
      debugPrint('Error occurring while saving auth pref :$e');
    }
  }
}
