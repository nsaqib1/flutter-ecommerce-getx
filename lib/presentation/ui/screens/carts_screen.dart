import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/cart_list_controller.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Get.find<AuthController>().token;
      Get.find<CartListController>().getCartList(token.toString());
    });
  }

  Future<void> _getCartList() async {}

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
        body: GetBuilder<CartListController>(builder: (cartListController) {
          return Visibility(
            visible: cartListController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartListController.cartListModel.cartItemList?.length ?? 0,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CartItem(cartItemModel: cartListController.cartListModel.cartItemList![index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                ),
                const CheckOutCard(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
