import 'package:get/get.dart';

import 'water_list_logic.dart';

class WaterListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
