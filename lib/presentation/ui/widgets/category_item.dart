import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category_list_item.dart';
import '../screens/product_list_screen.dart';
import '../utility/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final CategoryListItem category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            category: category.categoryName ?? '',
          ),
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                category.categoryImg ?? '',
                width: 40,
                height: 40,
              ),
            ),
          ),
          Text(
            category.categoryName ?? '',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
