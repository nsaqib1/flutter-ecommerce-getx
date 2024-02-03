import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> addToCart({
    required int productId,
    required String color,
    required String size,
    required String token,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "product_id": productId,
      "color": color,
      "size": size,
    };
    final response = await NetworkCaller().postRequest(
      Urls.addToCart,
      body: inputParams,
      token: token,
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
