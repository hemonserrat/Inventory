// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

URecord _$URecordFromJson(Map<String, dynamic> json) {
  return URecord(json['stock'] == null
      ? null
      : UStock.fromJson(json['stock'] as Map<String, dynamic>));
}

Map<String, dynamic> _$URecordToJson(URecord instance) =>
    <String, dynamic>{'stock': instance.stock};

UStock _$UStockFromJson(Map<String, dynamic> json) {
  return UStock(json['value'] as String);
}

Map<String, dynamic> _$UStockToJson(UStock instance) =>
    <String, dynamic>{'value': instance.value};
