import 'package:json_annotation/json_annotation.dart';

import 'club.dart';

part 'explorer_model.g.dart';

@JsonSerializable()
class ExplorerModel {
  List<Club>? clubs;

  ExplorerModel({this.clubs});

  factory ExplorerModel.fromJson(Map<String, dynamic> json) {
    return _$ExplorerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExplorerModelToJson(this);
}
