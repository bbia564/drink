import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'water_third_logic.dart';

class WaterThirdPage extends GetView<WaterThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = [
      'Drinking interval',
      'System reminder',
      'Clean all records',
      'Version'
    ];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 0
            ? <Widget>[
                Image.asset(
                  'assets/sub.webp',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ).gestures(onTap: () {
                  controller.waterChange(isAdd: false);
                }),
                Obx(() {
                  return Text(controller.intervalTime.value.toString());
                }).marginSymmetric(horizontal: 20),
                Image.asset(
                  'assets/add.webp',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ).gestures(onTap: () {
                  controller.waterChange();
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            : index == 3
                ? const Text("1.0.0")
                : Visibility(
                    visible: index == 1,
                    child: Obx(() {
                      return Switch(
                          activeTrackColor: Colors.green,
                          value: controller.sysRemind.value,
                          onChanged: (v) {
                            controller.remindChange();
                          });
                    })),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          controller.cleanWaterData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _item(0, context),
                _item(1, context),
                _item(2, context),
                _item(3, context),
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
