import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/product_model.dart';
import 'package:flutter_ecommerce_getx/data/models/wish_list_model.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

import '../../controllers/main_bottom_nav_controller.dart';
import '../widgets/product_card_item.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WishListController>().getWishList(
        Get.find<AuthController>().token ?? "",
      );
    });
  }

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
            'Wishlist',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GetBuilder<WishListController>(builder: (wishListController) {
            return Visibility(
              visible: wishListController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: wishListController.wishListModel.wishItemList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.90,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: ProductCardItem(product: wishListController.wishListModel.wishItemList![index].product ?? ProductModel(), isWishListed: true));
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
