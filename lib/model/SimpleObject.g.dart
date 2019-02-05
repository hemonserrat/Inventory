// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SimpleObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalog _$CatalogFromJson(Map<String, dynamic> json) {
  return Catalog(
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      imgurl: json['imgurl'] == null
          ? null
          : ImageUrl.fromJson(json['imgurl'] as Map<String, dynamic>),
      stock: json['stock'] == null
          ? null
          : Stock.fromJson(json['stock'] as Map<String, dynamic>),
      cost: json['cost'] == null
          ? null
          : Cost.fromJson(json['cost'] as Map<String, dynamic>),
      Record_number: json['Record_number'] == null
          ? null
          : RecordNumber.fromJson(
              json['Record_number'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CatalogToJson(Catalog instance) => <String, dynamic>{
      'item': instance.item,
      'category': instance.category,
      'imgurl': instance.imgurl,
      'stock': instance.stock,
      'cost': instance.cost,
      'Record_number': instance.Record_number
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$ItemToJson(Item instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

ImageUrl _$ImageUrlFromJson(Map<String, dynamic> json) {
  return ImageUrl(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$ImageUrlToJson(ImageUrl instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$StockToJson(Stock instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

Cost _$CostFromJson(Map<String, dynamic> json) {
  return Cost(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$CostToJson(Cost instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

RecordNumber _$RecordNumberFromJson(Map<String, dynamic> json) {
  return RecordNumber(json['type'] as String, json['value'] as String);
}

Map<String, dynamic> _$RecordNumberToJson(RecordNumber instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};
