import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/cart_list_controller.dart';
import 'package:get/get.dart';

import '../../screens/checkout_screen.dart';
import '../../utility/app_colors.dart';

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              Obx(
                () => Text(
                  "\$${Get.find<CartListController>().totalPrice}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const CheckoutScreen());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              elevation: 0,
            ),
            child: const Text("Checkout"),
          ),
        ],
      ),
    );
  }
}
