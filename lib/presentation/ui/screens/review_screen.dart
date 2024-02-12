import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/review_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/review_add_screen.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewController>().getReviewList(
      widget.productId,
      Get.find<AuthController>().token ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Reviews',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ReviewController>(builder: (reviewController) {
              return Visibility(
                visible: reviewController.inProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.separated(
                  itemCount: reviewController.reviewListModel.data?.length ?? 0,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                foregroundColor: Colors.grey.shade600,
                                radius: 20,
                                child: const Icon(Icons.person_2_outlined),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewController.reviewListModel.data![index].profile?.cusName ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 18,
                                        color: AppColors.primaryColor,
                                      ),
                                      Text(
                                        double.parse(reviewController.reviewListModel.data![index].rating ?? "1").toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            reviewController.reviewListModel.data![index].description ?? "",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              );
            }),
          ),
          AddReviewCard(productId: widget.productId),
        ],
      ),
    );
  }
}

class AddReviewCard extends StatelessWidget {
  const AddReviewCard({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<ReviewController>(builder: (reviewController) {
            final int n = reviewController.reviewListModel.data?.length ?? 0;
            return Text(
              "Reviews ($n)",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              Get.to(ReviewAddScreen(productId: productId));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
