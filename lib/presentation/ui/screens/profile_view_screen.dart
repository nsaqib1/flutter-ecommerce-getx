import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/read_profile_data_controller.dart';
import 'package:get/get.dart';

import 'auth/verify_email_screen.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReadProfileDataController>().readProfileData(
      Get.find<AuthController>().token ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.find<AuthController>().clearAuthData();
              Get.offAll(const VerifyEmailScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GetBuilder<ReadProfileDataController>(builder: (controller) {
            final profile = controller.profile;
            return Visibility(
              visible: controller.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildTextField("Name", profile.cusName),
                  buildTextField("Address", profile.cusAdd, true),
                  buildTextField("City", profile.cusCity),
                  buildTextField("State", profile.cusState),
                  buildTextField("Post Code", profile.cusPostcode),
                  buildTextField("Country", profile.cusCountry),
                  buildTextField("Phone", profile.cusPhone),
                  buildTextField("Fax", profile.cusFax),
                  const SizedBox(height: 15),
                  const Text(
                    "Shipping Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildTextField("Shipping Name", profile.shipName),
                  buildTextField("Shipping Address", profile.shipAdd, true),
                  buildTextField("Shipping City", profile.shipCity),
                  buildTextField("Shipping State", profile.shipState),
                  buildTextField("Shipping Post Code", profile.shipPostcode),
                  buildTextField("Shipping Country", profile.shipCountry),
                  buildTextField("Shipping Phone", profile.shipPhone),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  buildTextField(String label, String? value, [bool isAddress = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toString()),
        TextField(
          maxLines: isAddress ? 2 : null,
          minLines: isAddress ? 2 : null,
          decoration: InputDecoration(
            hintText: value,
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
