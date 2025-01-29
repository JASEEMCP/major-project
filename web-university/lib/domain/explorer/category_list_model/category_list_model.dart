import 'package:json_annotation/json_annotation.dart';

part 'category_list_model.g.dart';

@JsonSerializable()
class CategoryListModel {
  @JsonKey(name: 'category_name')
  String? categoryName;
  int? credits;

  CategoryListModel({this.categoryName, this.credits});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}
