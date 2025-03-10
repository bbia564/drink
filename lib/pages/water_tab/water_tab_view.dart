import 'package:drink_water/pages/water_first/water_first_logic.dart';
import 'package:drink_water/pages/water_first/water_first_view.dart';
import 'package:drink_water/pages/water_second/water_second_view.dart';
import 'package:drink_water/pages/water_third/water_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../water_second/water_second_logic.dart';
import 'water_tab_logic.dart';

class WaterTabPage extends GetView<WaterTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          WaterFirstPage(),
          WaterSecondPage(),
          WaterThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navWaterBars()),
    );
  }

  Widget _navWaterBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/item0Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/item0Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item1Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/item1Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item2Grey.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/item2Light.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
        if (index == 0) {
          WaterFirstLogic firstLogic = Get.put(WaterFirstLogic());
          firstLogic.getData();
        } else if (index == 1) {
          WaterSecondLogic secondLogic = Get.put(WaterSecondLogic());
          secondLogic.getData();
        }
      },
    );
  }
}
