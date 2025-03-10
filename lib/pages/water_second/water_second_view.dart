import 'package:drink_water/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'water_second_logic.dart';

class WaterSecondPage extends GetView<WaterSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
          child: GetBuilder<WaterSecondLogic>(
              init: WaterSecondLogic(),
              builder: (_) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 250,
                      padding: const EdgeInsets.all(12),
                      child: <Widget>[
                        const Text(
                          'Statistics of the week',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15,),
                         Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 170 / 40),
                              itemCount: 7,
                              itemBuilder: (_, index) {
                                return <Widget>[
                                  Visibility(
                                    visible: controller.list.value.isNotEmpty,
                                    child: LayoutBuilder(builder: (_, max) {
                                      return Container(
                                        width: 10,
                                        height: 150 *
                                            controller.weekList[index].length /
                                            controller.list.value.length,
                                      ).decorated(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5));
                                    }),
                                  ),
                                  Text(
                                    controller.weekTitles[index],
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ].toColumn(mainAxisAlignment: MainAxisAlignment.end);
                              }),
                                                 )
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                    ).decorated(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    const Text(
                      'Historical record',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                      Text(entity.detailsRecordTime)
                                    ].toColumn(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                    <Widget>[
                                      const Text(
                                        'Intake',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text('${entity.water} ml water')
                                    ].toColumn(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                    )
                                  ].toRow(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween),
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
