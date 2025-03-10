import 'package:drink_water/db_water/db_water.dart';
import 'package:drink_water/pages/no_network/no_network_binding.dart';
import 'package:drink_water/pages/no_network/no_network_view.dart';
import 'package:drink_water/pages/water_first/water_first_binding.dart';
import 'package:drink_water/pages/water_first/water_first_view.dart';
import 'package:drink_water/pages/water_list/water_list_binding.dart';
import 'package:drink_water/pages/water_list/water_list_view.dart';
import 'package:drink_water/pages/water_second/water_second_binding.dart';
import 'package:drink_water/pages/water_second/water_second_view.dart';
import 'package:drink_water/pages/water_tab/water_tab_binding.dart';
import 'package:drink_water/pages/water_tab/water_tab_view.dart';
import 'package:drink_water/pages/water_third/water_third_binding.dart';
import 'package:drink_water/pages/water_third/water_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_water/db_engine.dart';

Color primaryColor = const Color(0xff379fff);
Color bgColor = const Color(0xfff4f8fb);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBWater().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Drinks,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Drinks = [
  GetPage(name: '/', page: () => WaterListView(), binding: WaterListBinding()),
  GetPage(name: '/waterTab', page: () => WaterTabPage(), binding: WaterTabBinding()),
  GetPage(name: '/waterFirst', page: () => WaterFirstPage(), binding: WaterFirstBinding()),
  GetPage(name: '/melation', page: () => DbEngine()),
  GetPage(name: '/waterSecond', page: () => WaterSecondPage(), binding: WaterSecondBinding()),
  GetPage(name: '/waterThird', page: () => WaterThirdPage(), binding: WaterThirdBinding()),
  GetPage(name: '/no_net', page: () => NoNetworkPage(), binding: NoNetworkBinding()),
];
