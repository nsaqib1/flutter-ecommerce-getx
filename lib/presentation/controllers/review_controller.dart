import 'package:flutter_ecommerce_getx/data/models/review_list_model.dart';
import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  ReviewListModel _reviewListModel = ReviewListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  ReviewListModel get reviewListModel => _reviewListModel;

  int _statusCode = 0;
  int get statusCode => _statusCode;

  Future<bool> getReviewList(int id, String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(
      Urls.reviewList(id),
      token: token,
    );
    if (response.isSuccess) {
      _reviewListModel = ReviewListModel.fromJson(response.responseData);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> addReview({
    required String desc,
    required int id,
    required String rating,
    required String token,
  }) async {
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
}
