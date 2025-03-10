import 'package:drink_water/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'water_first_logic.dart';

class WaterFirstPage extends GetView<WaterFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
          child: GetBuilder<WaterFirstLogic>(init: WaterFirstLogic(),builder: (_) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                controller.settingEntity == null
                    ? Container(
                  width: 220,
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    'Setting',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
                    .decorated(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12))
                    .gestures(onTap: () {
                  controller.settingWater();
                })
                    : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    Expanded(
                        child: <Widget>[
                          Text(
                            controller.settingEntity!.historyRecordTime,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '${controller.settingEntity!.water} ml water',
                            style: const TextStyle(color: Colors.grey),
                          ).marginSymmetric(vertical: 8),
                          Container(
                            width: 120,
                            height: 44,
                            alignment: Alignment.center,
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                              .decorated(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12))
                              .gestures(onTap: () {
                                controller.addWater();
                          })
                        ].toColumn(
                            crossAxisAlignment: CrossAxisAlignment.start)),
                    Image.asset(
                      'assets/icon0.webp',
                      width: 84,
                      height: 84,
                      fit: BoxFit.cover,
                    )
                  ].toRow(),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                const Text(
                  'Historical record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ).marginSymmetric(vertical: 15),
                Obx(() {
                  return controller.list.value.isEmpty
                      ? Container(
                    alignment: Alignment.center,
                    child: const Text('No data'),
                  ).constrained(minHeight: 80)
                      : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.list.value.length,
                      itemBuilder: (_, index) {
                        final entity = controller.list.value[index];
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: <Widget>[
                            <Widget>[
                              const Text(
                                'Time',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(entity.historyRecordTime)
                            ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            <Widget>[
                              const Text(
                                'Intake',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text('${entity.water} ml water')
                            ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.end,
                            )
                          ].toRow(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween),
                        )
                            .decorated(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15))
                            .marginOnly(bottom: 10);
                      });
                })
              ].toColumn(),
            );
          }).marginAll(15)),
    );
  }
}
