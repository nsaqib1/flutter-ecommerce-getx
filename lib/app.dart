import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth/verify_otp_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:get/get.dart';

import 'presentation/ui/screens/auth/splash_screen.dart';
import 'presentation/ui/utility/app_theme_data.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(VerifyOtpController());
    Get.put(MainBottomNavController());
  }
}
