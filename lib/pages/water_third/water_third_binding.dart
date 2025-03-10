import 'package:get/get.dart';

import 'water_third_logic.dart';

class WaterThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaterThirdLogic());
  }
}
