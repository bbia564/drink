import 'package:get/get.dart';

import '../../db_water/db_water.dart';
import '../../db_water/water_entity.dart';

class WaterSecondLogic extends GetxController {

  DBWater dbWater = Get.find();

  var list = <WaterEntity>[].obs;
  var weekList = <List<WaterEntity>>[];

  final weekTitles = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  void getData() async {
    final result = await dbWater.getWeeklyWaterData();
    weekList = result;
    list.value = result.expand((element) => element).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
