import 'package:flutter_ecommerce_getx/data/models/wish_list_model.dart';
import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class WishListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  WishListModel _wishListModel = WishListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  WishListModel get wishListModel => _wishListModel;

  int _statusCode = 0;
  int get statusCode => _statusCode;

  Future<bool> getWishList(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(
      Urls.wishList,
      token: token,
    );
    if (response.isSuccess) {
      _wishListModel = WishListModel.fromJson(response.responseData);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> addWishListtItem(int id, String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(
      Urls.addToWishList(id),
      token: token,
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      _statusCode = response.statusCode;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> deleteWishListtItem(int id, String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(
      Urls.removeFromWishList(id),
      token: token,
    );
    if (response.isSuccess) {
      _wishListModel = WishListModel();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
