import 'package:drink_water/db_water/db_water.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../water_first/water_first_logic.dart';

class WaterThirdLogic extends GetxController {

  DBWater dbWater = Get.find();

  var sysRemind = true.obs;
  var intervalTime = 20.obs;

  void waterChange({bool isAdd = true}) async {
    if (isAdd) {
      if (intervalTime.value > 200) {
        return;
      }
      intervalTime.value += 1;
    } else {
      if (intervalTime.value < 10) {
        return;
      }
      intervalTime.value -= 1;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('intervalTime', intervalTime.value);
  }

  void remindChange() async {
    sysRemind.value = !sysRemind.value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sysRemind', sysRemind.value);
    WaterFirstLogic firstLogic = Get.put(WaterFirstLogic());
    firstLogic.getData();
  }

  cleanWaterData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbWater.cleanWaterData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutWaterUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 73,
        height: 73,
      ),
      children: [
        const Text(
            """We can record your drinking water"""),
      ],
      context: context,
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    intervalTime.value = prefs.getInt('intervalTime') ?? 20;
    sysRemind.value = prefs.getBool('sysRemind') ?? true;
    super.onInit();
  }

}
