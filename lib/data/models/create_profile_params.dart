class CreateProfileParams {
  final String firstName;
  final String lastName;
  final String mobile;
  final String city;
  final String shippingAddress;

  CreateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.city,
    required this.shippingAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "cus_name": "$firstName $lastName",
      "cus_add": shippingAddress,
      "cus_city": city,
      "cus_state": "Dhaka",
      "cus_postcode": "1207",
      "cus_country": "Bangladesh",
      "cus_phone": "01785388919",
      "cus_fax": "01785388919",
      "ship_name": "$firstName $lastName",
      "ship_add": shippingAddress,
      "ship_city": "Dhaka",
      "ship_state": "Dhaka",
      "ship_postcode": "1207",
      "ship_country": "Bangladesh",
      "ship_phone": "01785388919"
    };
  }
}
