import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/cart_item_model.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/cart_list_controller.dart';
import 'package:get/get.dart';

import '../../utility/app_colors.dart';
import '../item_counter.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItemModel,
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 10,
            child: Image.network(cartItemModel.product!.image!),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 22,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItemModel.product?.title ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "Color: ${cartItemModel.color}, Size: ${cartItemModel.size}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "৳${cartItemModel.product?.price}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ItemCounter(
                      onChange: (value) {
                        Get.find<CartListController>().updateQuantity(cartItemModel.id ?? 0, value);
                      },
                      value: int.tryParse(cartItemModel.qty ?? "1") ?? 1,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
