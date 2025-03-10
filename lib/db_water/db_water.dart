
import 'package:drink_water/db_water/water_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class DBWater extends GetxService {
  late Database dbBase;

  Future<DBWater> init() async {
    await createWaterDB();
    return this;
  }

  createWaterDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'water.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createWaterTable(db);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('intervalTime', 20);
          await prefs.setBool('sysRemind', true);
        });
  }

  createWaterTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS water (id INTEGER PRIMARY KEY, createTime TEXT, water INTEGER, drinkTime TEXT, record INTEGER)');
  }

  insertWater(WaterEntity entity) async {
    final id = await dbBase.insert('water', {
      'createTime': entity.createTime.toIso8601String(),
      'water': entity.water,
      'drinkTime': entity.drinkTime.toIso8601String(),
      'record': entity.record,
    });
    return id;
  }

  updateWater(WaterEntity entity) async {
    await dbBase.update(
        'water',
        {
          'water': entity.water,
          'drinkTime': entity.drinkTime.toIso8601String(),
          'record': entity.record,
        },
        where: 'id = ?',
        whereArgs: [entity.id]);
  }

  cleanWaterData() async {
    await dbBase.delete('water');
  }

  Future<List<WaterEntity>> getWaterAllData() async {
    var result = await dbBase.query('water', orderBy: 'createTime DESC');
    return result.map((e) => WaterEntity.fromJson(e)).toList();
  }

  Future<List<WaterEntity>> getThisWeekWaterEntities() async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    final List<Map<String, dynamic>> maps = await dbBase.query(
      'water',
      where: 'drinkTime BETWEEN ? AND ?',
      whereArgs: [startOfWeek.toIso8601String(), endOfWeek.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return WaterEntity.fromJson(maps[i]);
    });
  }

  Future<List<List<WaterEntity>>> getWeeklyWaterData() async {
    List<WaterEntity> waterEntities = await getThisWeekWaterEntities();
    Map<int, List<WaterEntity>> groupedData = {};
    for (var entity in waterEntities) {
      int dayOfWeek = entity.drinkTime.weekday;
      groupedData.putIfAbsent(dayOfWeek, () => []).add(entity);
    }
    List<List<WaterEntity>> weeklyData = [];
    for (int i = 1; i <= 7; i++) {
      weeklyData.add(groupedData[i] ?? []);
    }

    return weeklyData;
  }
}
