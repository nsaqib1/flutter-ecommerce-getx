import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/category_list_item.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/category_controller.dart';
import 'package:get/get.dart';

import '../../controllers/main_bottom_nav_controller.dart';
import '../widgets/category_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
            'Category',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryController>().getCategoryList();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GetBuilder<CategoryController>(builder: (controller) {
              return Visibility(
                visible: controller.inProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: controller.categoryListModel.categoryList?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.95,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: CategoryItem(
                        category: controller.categoryListModel.categoryList?[index] ?? CategoryListItem(),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
