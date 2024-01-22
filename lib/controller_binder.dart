import 'package:get/get.dart';
import 'presentation/controllers/auth/otp_timer_countdown_controller.dart';
import 'presentation/controllers/auth/send_email_otp_controller.dart';
import 'presentation/controllers/auth/verify_otp_controller.dart';
import 'presentation/controllers/main_bottom_nav_controller.dart';
import 'presentation/controllers/read_profile_data_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpTimerCountdownController());
    Get.put(MainBottomNavController());
    Get.put(SendEmailOtpController());
    Get.put(ReadProfileDataController());
    Get.put(VerifyOTPController());
  }
}
