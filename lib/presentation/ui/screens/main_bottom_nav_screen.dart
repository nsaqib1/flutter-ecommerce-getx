import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/category_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/home_banner_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/new_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/special_product_controller.dart';
import 'package:get/get.dart';

import '../../controllers/main_bottom_nav_controller.dart';
import '../utility/app_colors.dart';
import 'carts_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'wishlist_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryScreen(),
    CartsScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeBannerController>().getBannerList();
    Get.find<CategoryController>().getCategoryList();
    Get.find<PopularProductController>().getPopularListModel();
    Get.find<SpecialProductController>().getSpecialProductList();
    Get.find<NewProductController>().getNewProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Carts'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined), label: 'Wishlist'),
          ],
        ),
      );
    });
  }
}
