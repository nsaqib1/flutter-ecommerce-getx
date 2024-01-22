import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth/otp_timer_countdown_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controllers/auth/verify_otp_controller.dart';
import '../../utility/app_colors.dart';
import '../../widgets/app_logo.dart';
import '../main_bottom_nav_screen.dart';
import 'complete_profile_screen.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Get.find<OtpTimerCountdownController>().startOtpCodeCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 4 digit OTP code has been sent',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  controller: _otpController,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      inactiveColor: AppColors.primaryColor,
                      selectedFillColor: Colors.transparent,
                      selectedColor: Colors.purple),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOTPController>(
                    builder: (verifyOtpController) {
                      return Visibility(
                        visible: verifyOtpController.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final bool response = await verifyOtpController.verifyOTP(widget.email, _otpController.text);
                              if (response) {
                                if (verifyOtpController.shouldNavigateCompleteProfile) {
                                  Get.to(() => const CompleteProfileScreen());
                                } else {
                                  Get.offAll(() => const MainBottomNavScreen());
                                }
                              } else {
                                Get.showSnackbar(
                                  GetSnackBar(
                                    title: 'OTP verification failed',
                                    message: verifyOtpController.errorMessage,
                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Next'),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<OtpTimerCountdownController>(
                  builder: (controller) => RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        const TextSpan(text: 'This code will expire '),
                        TextSpan(
                          text: '${controller.otpCodeExpirationTime}s',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<OtpTimerCountdownController>(
                  builder: (controller) => TextButton(
                    onPressed: controller.otpCodeExpirationTime == 0 ? () {} : null,
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
