import 'package:flutter_ecommerce_getx/data/models/product_model.dart';

class WishListModel {
  String? msg;
  List<WishItemModel>? wishItemList;

  WishListModel({this.msg, this.wishItemList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishItemList = <WishItemModel>[];
      json['data'].forEach((v) {
        wishItemList!.add(WishItemModel.fromJson(v));
      });
    }
  }
}

class WishItemModel {
  int? id;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  WishItemModel({
    this.id,
    this.productId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  WishItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}
