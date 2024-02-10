import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/data/models/profile_model.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/complete_profile_controller.dart';
import 'package:get/get.dart';
import '../../../../data/models/create_profile_params.dart';
import '../../widgets/app_logo.dart';
import '../main_bottom_nav_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.token});

  final String token;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();

  final TextEditingController _shipNameController = TextEditingController();
  final TextEditingController _shipAddressController = TextEditingController();
  final TextEditingController _shipCityController = TextEditingController();
  final TextEditingController _shipPostcodeController = TextEditingController();
  final TextEditingController _shipStateController = TextEditingController();
  final TextEditingController _shipCountryController = TextEditingController();
  final TextEditingController _shipPhoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _faxController.dispose();

    _shipNameController.dispose();
    _shipAddressController.dispose();
    _shipCityController.dispose();
    _shipPostcodeController.dispose();
    _shipStateController.dispose();
    _shipCountryController.dispose();
    _shipPhoneController.dispose();
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
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Full Name is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(hintText: 'Address'),
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
                  controller: _stateController,
                  decoration: const InputDecoration(hintText: 'State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "State is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _postcodeController,
                  decoration: const InputDecoration(hintText: 'Post Code'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "PostCode is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(hintText: 'Country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Country is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(hintText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Phone Number is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _faxController,
                  decoration: const InputDecoration(hintText: 'Fax'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Fax Number is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(height: 20),
                const Text("Shipping Information"),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _shipNameController,
                  decoration: const InputDecoration(hintText: 'Shipping Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Name is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipAddressController,
                  decoration: const InputDecoration(hintText: 'Shipping Address'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Address is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCityController,
                  decoration: const InputDecoration(hintText: 'Shipping City'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping City is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipStateController,
                  decoration: const InputDecoration(hintText: 'Shipping State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping State is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPostcodeController,
                  decoration: const InputDecoration(hintText: 'Shipping Post Code'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Post Code is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCountryController,
                  decoration: const InputDecoration(hintText: 'Shipping Country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Country is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPhoneController,
                  decoration: const InputDecoration(hintText: 'Shipping Phone'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Shipping Phone Number is Required!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _completeProfile,
                          child: const Text('Complete'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _completeProfile() async {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<CompleteProfileController>();
      final response = await controller.createProfile(
        widget.token,
        CreateProfileParams(
          cusName: _nameController.text,
          cusAdd: _addressController.text,
          cusCity: _cityController.text,
          cusState: _stateController.text,
          cusPostcode: _postcodeController.text,
          cusCountry: _countryController.text,
          cusPhone: _phoneController.text,
          cusFax: _faxController.text,
          shipName: _shipNameController.text,
          shipAdd: _shipAddressController.text,
          shipCity: _shipCityController.text,
          shipState: _shipStateController.text,
          shipPostcode: _shipPostcodeController.text,
          shipCountry: _shipCountryController.text,
          shipPhone: _shipPhoneController.text,
        ),
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
  }
}
