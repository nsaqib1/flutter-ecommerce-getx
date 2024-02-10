import 'package:flutter_ecommerce_getx/data/models/cart_item_model.dart';
import 'package:get/get.dart';

import '../../data/models/cart_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  CartListModel _cartListModel = CartListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  CartListModel get cartListModel => _cartListModel;

  final RxDouble _totalPrice = 0.0.obs;

  RxDouble get totalPrice => _totalPrice;

  Future<bool> getCartList(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(
      Urls.cartList,
      token: token,
    );
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseData);
      _totalPrice.value = _calculateTotalPrice;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  void updateQuantity(int id, int quantity) {
    _cartListModel.cartItemList?.firstWhere((element) => element.id == id).qty = quantity.toString();
    _totalPrice.value = _calculateTotalPrice;
  }

  double get _calculateTotalPrice {
    double total = 0;
    for (CartItemModel item in _cartListModel.cartItemList ?? []) {
      total += (double.tryParse(item.product?.price ?? '1') ?? 1) * (double.tryParse(item.qty ?? "1") ?? 1);
      print(item.product!.stock!);
      print(item.product!.price!);
    }
    _totalPrice.value = total;
    return total;
  }
}
