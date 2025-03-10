import 'package:get/get.dart';

import 'water_first_logic.dart';

class WaterFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaterFirstLogic());
  }
}
