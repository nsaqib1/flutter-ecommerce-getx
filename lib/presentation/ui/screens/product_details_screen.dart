import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/product_details_data.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/add_to_cart_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/product_details_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/app_colors.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/color_converter.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/item_counter.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        elevation: 0,
      ),
      body: GetBuilder<ProductDetailsController>(builder: (controller) {
        final List<String> images = [
          controller.productDetailsData.img1 ?? "",
          controller.productDetailsData.img2 ?? "",
          controller.productDetailsData.img3 ?? "",
          controller.productDetailsData.img4 ?? "",
        ];

        return Visibility(
          visible: controller.inProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ProductImageCarousel(images: images),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: productDetailsBody(controller.productDetailsData),
                      ),
                    ],
                  ),
                ),
              ),
              productPriceCard(widget.productId),
            ],
          ),
        );
      }),
    );
  }

  Widget productDetailsBody(ProductDetailsData product) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.product!.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const ItemCounter(),
            ],
          ),
          const SizedBox(height: 10),
          reviewSnippet(product.product!.star!),
          ColorSelector(
            colors: product.color!.split(",").map((e) => ColorConverter.getColorFromHex(e)).toList(),
            onChange: (color) {
              _selectedColor = "#${color.toString().substring(10, 16)}";
            },
          ),
          const SizedBox(height: 20),
          SizeSelector(
            sizes: product.size!.split(",").toList(),
            onChange: (size) {
              _selectedSize = size;
            },
          ),
          const SizedBox(height: 20),
          productDescription(product.des!),
        ],
      );

  Widget reviewSnippet(double star) => Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          const SizedBox(width: 2),
          Text(star.toStringAsFixed(1)),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: const Text("Reviews"),
          ),
          const SizedBox(width: 8),
          Card(
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(
                Icons.favorite_border,
                size: 18,
                color: Colors.grey.shade300,
              ),
            ),
          )
        ],
      );

  Widget productDescription(String description) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      );

  Widget productPriceCard(int productId) => Container(
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
                  "Price",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                const Text(
                  "\$100.00",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            GetBuilder<AddToCartController>(builder: (controller) {
              if (controller.inProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () async {
                  if (_selectedColor == null || _selectedSize == null) {
                    Get.snackbar("Add to cart failed", "Please select size and color");
                  } else if (await Get.find<AuthController>().isLoggedIn() == false) {
                    Get.offAll(const VerifyEmailScreen());
                  } else {
                    final String token = Get.find<AuthController>().token!;
                    final result = await controller.addToCart(
                      productId: productId,
                      color: _selectedColor!,
                      size: _selectedSize!,
                      token: token,
                    );

                    if (result) {
                      Get.snackbar(
                        "Success",
                        "Product added to cart!",
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar("Add to cart failed!", controller.errorMessage);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  elevation: 0,
                ),
                child: const Text("Add To Cart"),
              );
            }),
          ],
        ),
      );
}
