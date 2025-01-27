import 'package:json_annotation/json_annotation.dart';

part 'category_list_model.g.dart';

@JsonSerializable()
class CategoryListModel {
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'category_name')
  String? categoryName;
  String? level;
  int? credits;

  CategoryListModel({
    this.categoryId,
    this.categoryName,
    this.level,
    this.credits,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}
