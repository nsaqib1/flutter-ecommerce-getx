import 'dart:async';

import 'package:get/get.dart';

class OtpTimerCountdownController extends GetxController {
  int _otpCodeExpirationTime = 120;
  int get otpCodeExpirationTime => _otpCodeExpirationTime;

  void startOtpCodeCountdown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_otpCodeExpirationTime > 0) {
          _otpCodeExpirationTime--;
          update();
        } else {
          return;
        }
      },
    );
  }
}
