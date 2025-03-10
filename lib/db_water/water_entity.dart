import 'package:intl/intl.dart';

class WaterEntity {
  int id;
  DateTime createTime;
  int water;
  DateTime drinkTime;
  int record;

  WaterEntity({
    required this.id,
    required this.createTime,
    required this.water,
    required this.drinkTime,
    required this.record,
  });

  factory WaterEntity.fromJson(Map<String, dynamic> json) {
    return WaterEntity(
      id: json['id'],
      createTime: DateTime.parse(json['createTime']),
      water: json['water'],
      drinkTime: DateTime.parse(json['drinkTime']),
      record: json['record'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createTime': createTime.toIso8601String(),
      'water': water,
      'drinkTime': drinkTime.toIso8601String(),
      'record': record,
    };
  }

  String get historyRecordTime => DateFormat('hh:mm a').format(drinkTime);

  String get detailsRecordTime => DateFormat('yyyy-MM-dd hh:mm a').format(drinkTime);
}