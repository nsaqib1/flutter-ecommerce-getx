import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_bottom_nav_controller.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/cart/check_out_card.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
          ),
          title: const Text(
            'Cart',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const CartItem(),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
              ),
            ),
            const CheckOutCard(),
          ],
        ),
      ),
    );
  }
}
