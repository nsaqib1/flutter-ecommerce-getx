import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../widgets/product_card_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.category, this.categoryId});

  final String? category;
  final int? categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      Get.find<ProductController>().getProductList(categoryId: widget.categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? "Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductController>(builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: controller.productListModel.productList?.isNotEmpty ?? false,
              replacement: const Center(
                child: Text("No Products!"),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.90,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(child: ProductCardItem(product: controller.productListModel.productList![index]));
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
