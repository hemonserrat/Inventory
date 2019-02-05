import 'package:json_annotation/json_annotation.dart';

part 'SimpleObject.g.dart';

class SimpleObject {
  const SimpleObject({
    this.records,
  });

  @JsonKey(name: 'records')
  final List<Catalog> records;

  factory SimpleObject.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return SimpleObject(
        records: json['records'] != null
            ? List<Catalog>.from(
                json['records'].map((o) => Catalog.fromJson(o)))
            : null);
  }
}

@JsonSerializable()
class Catalog {
  const Catalog({this.item, this.category,
    this.imgurl, this.stock, this.cost,
    this.Record_number});

  final Item item;

  final Category category;

  final ImageUrl imgurl;

  final Stock stock;

  final Cost cost;

  final RecordNumber Record_number;

  factory Catalog.fromJson(Map<String, dynamic> json) =>
      _$CatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogToJson(this);
}

@JsonSerializable()
class Item {
  final String type;
  final String value;

  Item(this.type, this.value);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Category {
  final String type;
  final String value;

  Category(this.type, this.value);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class ImageUrl {
  final String type;
  final String value;

  ImageUrl(this.type, this.value);

  factory ImageUrl.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlToJson(this);
}

@JsonSerializable()
class Stock {
  final String type;
  final String value;

  Stock(this.type, this.value);

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);
}

@JsonSerializable()
class Cost {
  final String type;
  final String value;

  Cost(this.type, this.value);

  factory Cost.fromJson(Map<String, dynamic> json) => _$CostFromJson(json);

  Map<String, dynamic> toJson() => _$CostToJson(this);
}

@JsonSerializable()
class RecordNumber {
  final String type;
  final String value;

  RecordNumber(this.type, this.value);

  factory RecordNumber.fromJson(Map<String, dynamic> json) => _$RecordNumberFromJson(json);

  Map<String, dynamic> toJson() => _$RecordNumberToJson(this);
}
