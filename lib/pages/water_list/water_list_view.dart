import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'water_list_logic.dart';

class WaterListView extends GetView<PageLogic> {
  const WaterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.hartmann.value
              ? const CircularProgressIndicator(color: Colors.pinkAccent)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.aomnupg();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
