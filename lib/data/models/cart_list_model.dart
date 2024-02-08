import 'package:flutter_ecommerce_getx/data/models/cart_item_model.dart';

class CartListModel {
  String? msg;
  List<CartItemModel>? cartItemList;

  CartListModel({this.msg, this.cartItemList});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartItemList = <CartItemModel>[];
      json['data'].forEach((v) {
        cartItemList!.add(CartItemModel.fromJson(v));
      });
    }
  }
}
