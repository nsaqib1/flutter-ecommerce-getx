import 'package:flutter_ecommerce_getx/data/models/product_details_data.dart';
import 'package:flutter_ecommerce_getx/data/models/product_details_model.dart';
import 'package:flutter_ecommerce_getx/data/models/response_data.dart';
import 'package:flutter_ecommerce_getx/data/services/network_caller.dart';
import 'package:flutter_ecommerce_getx/data/utilities/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();
  ProductDetailsData get productDetailsData => _productDetailsModel.productDetailsDataList?.first ?? ProductDetailsData();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool result = false;
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(Urls.productDetails(productId));
    if (response.isSuccess && response.responseData["data"].length > 0) {
      _productDetailsModel = ProductDetailsModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return result;
  }
}
