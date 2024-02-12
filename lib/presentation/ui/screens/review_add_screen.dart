import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/review_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'auth/verify_email_screen.dart';

class ReviewAddScreen extends StatefulWidget {
  const ReviewAddScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ReviewAddScreen> createState() => _ReviewAddScreenState();
}

class _ReviewAddScreenState extends State<ReviewAddScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _rating = 5;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() == false) return;
    final result = await Get.find<ReviewController>().addReview(
      desc: _reviewController.text,
      id: widget.productId,
      rating: _rating.toString(),
      token: Get.find<AuthController>().token ?? "",
    );

    if (result) {
      _reviewController.clear();

      Get.snackbar(
        "Success",
        "Product review added!",
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final reviewController = Get.find<ReviewController>();
      if (reviewController.statusCode == 401) {
        Get.offAll(const VerifyEmailScreen());
      } else {
        Get.snackbar(
          "Product review failed!",
          reviewController.errorMessage,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Give Your Rating", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            RatingBar.builder(
              itemSize: 32,
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColors.primaryColor,
              ),
              onRatingUpdate: (rating) {
                _rating = rating.toInt();
                setState(() {});
              },
            ),
            const SizedBox(height: 25),
            const Text("Write a Review", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _reviewController,
                maxLines: 8,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Must have a description";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: GetBuilder<ReviewController>(builder: (reviewControlelr) {
                return Visibility(
                  visible: reviewControlelr.inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: _submit,
                    child: const Text("Submit"),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
