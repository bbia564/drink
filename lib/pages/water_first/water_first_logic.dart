import 'dart:async';

import 'package:drink_water/db_water/db_water.dart';
import 'package:drink_water/db_water/water_entity.dart';
import 'package:drink_water/pages/water_first/water_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';

class WaterFirstLogic extends GetxController {
  DBWater dbWater = Get.find();

  WaterEntity? settingEntity;

  var list = <WaterEntity>[].obs;

  Timer? _timer;

  void startTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final intervalTime = prefs.getInt('intervalTime') ?? 20;
    final sysRemind = prefs.getBool('sysRemind') ?? true;
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (settingEntity != null && list.value.isNotEmpty && sysRemind) {
        if (DateTime.now().difference(list.value.first.drinkTime).inMinutes > intervalTime) {
          Fluttertoast.showToast(msg: 'Please drink water');
        }
      }
    });
  }

  void getData() async {
    final result = await dbWater.getWaterAllData();
    settingEntity = result.where((element) => element.record == 1).firstOrNull;
    list.value = result
        .where((element) => element.record == 0)
        .toList()
        .where((e) =>
            e.drinkTime.year == DateTime.now().year &&
            e.drinkTime.month == DateTime.now().month &&
            e.drinkTime.day == DateTime.now().day)
        .toList();
    startTimer();
  }

  void addWater() async {
    await dbWater.insertWater(WaterEntity(
        id: 0,
        createTime: DateTime.now(),
        water: settingEntity?.water ?? 0,
        drinkTime: DateTime.now(),
        record: 0));
    getData();
    startTimer();
    Get.back();
  }

  void settingWater() async {
    var title = '';
    var drinkTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
    Get.bottomSheet(Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(15),
      child: GetBuilder<WaterFirstLogic>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              const Text('Setting drink water'),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 72,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  Expanded(
                      child: WaterTextField(
                          value: title,
                          maxLength: 4,
                          textAlign: TextAlign.center,
                          isInteger: true,
                          onChange: (v) {
                            title = v;
                          })),
                  const Text(
                    'ml',
                    style: TextStyle(fontSize: 20),
                  )
                ].toRow(),
              ).decorated(
                  color: const Color(0xfff4f8fb),
                  borderRadius: BorderRadius.circular(15)),
              const SizedBox(
                height: 15,
              ),
              DateTimePickerWidget(
                dateFormat: 'HH:mm',
                initDateTime: drinkTime,
                pickerTheme: const DateTimePickerTheme(
                    showTitle: false, cancel: null, confirm: null),
                onConfirm: (dateTime, List<int> index) {
                  drinkTime = dateTime;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
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
                  .gestures(onTap: () async {
                if (title.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter water');
                  return;
                }
                await dbWater.insertWater(WaterEntity(
                    id: 0,
                    createTime: DateTime.now(),
                    water: int.parse(title),
                    drinkTime: drinkTime,
                    record: 1));
                getData();
                Get.back();
                update();
              })
            ].toColumn(),
          ),
        );
      }),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
