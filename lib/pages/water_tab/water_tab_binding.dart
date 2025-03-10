import 'package:drink_water/pages/water_first/water_first_logic.dart';
import 'package:drink_water/pages/water_second/water_second_logic.dart';
import 'package:get/get.dart';

import '../water_third/water_third_logic.dart';
import 'water_tab_logic.dart';

class WaterTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaterTabLogic());
    Get.lazyPut(() => WaterFirstLogic());
    Get.lazyPut(() => WaterSecondLogic());
    Get.lazyPut(() => WaterThirdLogic());
  }
}
