import 'package:flutter_ecommerce_getx/presentation/controllers/add_to_cart_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/cart_list_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/category_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/complete_profile_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/create_invoice_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/home_banner_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/new_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/product_details_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/special_product_controller.dart';
import 'package:get/get.dart';
import 'presentation/controllers/main_bottom_nav_controller.dart';
import 'presentation/controllers/otp_timer_countdown_controller.dart';
import 'presentation/controllers/read_profile_data_controller.dart';
import 'presentation/controllers/send_email_otp_controller.dart';
import 'presentation/controllers/verify_otp_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(OtpTimerCountdownController());
    Get.put(MainBottomNavController());
    Get.put(SendEmailOtpController());
    Get.put(ReadProfileDataController());
    Get.put(VerifyOTPController());
    Get.put(CompleteProfileController());
    Get.put(HomeBannerController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(ProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(CartListController());
    Get.put(CreateInvoiceController());
  }
}
