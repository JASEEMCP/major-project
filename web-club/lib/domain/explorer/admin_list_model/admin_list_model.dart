import 'package:json_annotation/json_annotation.dart';

part 'admin_list_model.g.dart';

@JsonSerializable()
class AdminListModel {
  @JsonKey(name: 'staff_id')
  String? staffId;
  String? name;

  AdminListModel({this.staffId, this.name});

  factory AdminListModel.fromJson(Map<String, dynamic> json) {
    return _$AdminListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdminListModelToJson(this);
}
