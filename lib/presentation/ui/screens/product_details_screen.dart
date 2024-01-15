import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/app_colors.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/item_counter.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/color_variations.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/widgets/product_details/size_variations.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final List<String> _sizes = const ["X", "XL", "XXXL", "S"];
  final List<Color> _colors = [Colors.black, AppColors.primaryColor, Colors.brown, Colors.grey.shade300, Colors.grey.shade600];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const ProductImageCarousel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: productDetailsBody,
                  ),
                ],
              ),
            ),
          ),
          productPriceCard,
        ],
      ),
    );
  }

  Widget get productDetailsBody => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Happy New Year Special Deal\nSave 30%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              ItemCounter(),
            ],
          ),
          const SizedBox(height: 10),
          reviewSnippet,
          ColorVariations(colors: _colors),
          const SizedBox(height: 20),
          SizeVariations(sizes: _sizes),
          const SizedBox(height: 20),
          productDescription,
        ],
      );

  Widget get reviewSnippet => Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          const SizedBox(width: 2),
          const Text("4.8"),
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

  Widget get productDescription => Column(
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
            "Ad adipisicing magna culpa in irure ad proident dolore anim cupidatat magna.Reprehenderit esse consectetur minim irure id consectetur sunt adipisicing mollit et.",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      );

  Widget get productPriceCard => Container(
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                elevation: 0,
              ),
              child: const Text("Add To Cart"),
            ),
          ],
        ),
      );
}
