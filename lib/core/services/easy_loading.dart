import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void loadingService(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = const Color(0xFF5D9CEC)
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.black
    ..textColor = const Color(0xFF5D9CEC)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}