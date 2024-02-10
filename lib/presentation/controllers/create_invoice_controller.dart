import 'package:get/get.dart';

import '../../data/models/payment_method_list.dart';
import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class CreateInvoiceController extends GetxController {
  bool _inProgress = true;

  PaymentMethodListModel _paymentMethodListModel = PaymentMethodListModel();

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  PaymentMethodListModel get paymentMethodListModel => _paymentMethodListModel;

  String get errorMessage => _errorMessage;

  Future<bool> createInvoice(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.createInvoice, token: token);
    if (response.isSuccess) {
      _paymentMethodListModel = PaymentMethodListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
