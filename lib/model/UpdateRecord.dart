import 'package:json_annotation/json_annotation.dart';

part 'UpdateRecord.g.dart';

class UpdateRecord {
  final int app;
  final int id;
  final URecord record;

  UpdateRecord(this.app, this.id, this.record);

  UpdateRecord.fromJson(Map<String, dynamic> json)
      : app = json['app'],
        id = json['id'],
        record = json['record'];

  Map<String, dynamic> toJson() => {
        'app': app,
        'id': id,
        'record': record,
      };
}

@JsonSerializable()
class URecord {
  final UStock stock;

  URecord(this.stock);

  URecord.fromJson(Map<String, dynamic> json) : stock = json['stock'];

  Map<String, dynamic> toJson() => {
        'stock': stock,
      };
}

@JsonSerializable()
class UStock {
  final String value;

  UStock(this.value);

  UStock.fromJson(Map<String, dynamic> json) : value = json['value'];

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}
