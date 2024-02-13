import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/product_model.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/home_banner_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/new_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/special_product_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/product_list_screen.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/profile_view_screen.dart';
import 'package:get/get.dart';

import '../../../data/models/category_list_item.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/main_bottom_nav_controller.dart';
import '../utility/assets_path.dart';
import '../widgets/category_item.dart';
import '../widgets/home/banner_carousel.dart';
import '../widgets/home/circle_icon_button.dart';
import '../widgets/home/section_title.dart';
import '../widgets/product_card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              searchTextField,
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 210,
                child: GetBuilder<HomeBannerController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: BannerCarousel(bannerList: controller.bannerListModel.bannerList ?? []),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: 'All Categories',
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              SectionTitle(
                title: 'Popular',
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<PopularProductController>(
                builder: (controller) {
                  return productList(controller.productListModel.productList ?? [], controller.inProgress);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: 'Special',
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<SpecialProductController>(
                builder: (controller) {
                  return productList(controller.productListModel.productList ?? [], controller.inProgress);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: 'New',
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<NewProductController>(
                builder: (controller) {
                  return productList(controller.productListModel.productList ?? [], controller.inProgress);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 130,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categoryController.categoryListModel.categoryList?.length ?? 0,
            itemBuilder: (context, index) {
              return FittedBox(
                child: CategoryItem(
                  category: categoryController.categoryListModel.categoryList?[index] ?? CategoryListItem(),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox productList(List<ProductModel> productList, bool inProgress) {
    return SizedBox(
      height: 190,
      child: Visibility(
        visible: inProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: productList.length,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductCardItem(product: productList[index]);
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  TextFormField get searchTextField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () async {
            Get.to(const ProfileViewScreen());
          },
          iconData: Icons.person,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
