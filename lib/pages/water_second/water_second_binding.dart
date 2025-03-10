import 'package:get/get.dart';

import 'water_second_logic.dart';

class WaterSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaterSecondLogic());
  }
}
