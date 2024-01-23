import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/complete_profile_controller.dart';
import 'package:get/get.dart';
import '../../widgets/app_logo.dart';
import '../main_bottom_nav_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.token});

  final String token;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _shippingAddressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    _shippingAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Complete Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Get started with us with your details',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(hintText: 'First name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "First Name is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(hintText: 'Last name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Last Name is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Mobile Number is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(hintText: 'City'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "City Name is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shippingAddressController,
                  maxLines: 4,
                  decoration: const InputDecoration(hintText: 'Shipping address'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Address is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await controller.createProfile(
                              widget.token,
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              mobile: _mobileController.text.trim(),
                              city: _cityController.text.trim(),
                              shippingAddress: _shippingAddressController.text.trim(),
                            );

                            if (response) {
                              Get.offAll(const MainBottomNavScreen());
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: 'Complete profile failed',
                                  message: controller.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Complete'),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
