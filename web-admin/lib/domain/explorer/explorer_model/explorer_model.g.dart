// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explorer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExplorerModel _$ExplorerModelFromJson(Map<String, dynamic> json) =>
    ExplorerModel(
      clubs: (json['clubs'] as List<dynamic>?)
          ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExplorerModelToJson(ExplorerModel instance) =>
    <String, dynamic>{
      'clubs': instance.clubs,
    };
