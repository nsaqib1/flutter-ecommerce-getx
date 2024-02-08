class ProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? city;
  String? shippingAddress;
  String? email;
  String? createdAt;
  String? updatedAt;

  ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.city,
    this.shippingAddress,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json['cus_name'].toString().split(" ")[0];
    lastName = json['cus_name'].toString().split(" ")[1];
    mobile = json['cus_phone'];
    city = json['cus_city'];
    shippingAddress = json['ship_add'];
    email = json['cus_fax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // ProfileModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   mobile = json['mobile'];
  //   city = json['city'];
  //   shippingAddress = json['shippingAddress'];
  //   email = json['email'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['firstName'] = firstName;
  //   data['lastName'] = lastName;
  //   data['mobile'] = mobile;
  //   data['city'] = city;
  //   data['shippingAddress'] = shippingAddress;
  //   data['email'] = email;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   return data;
  // }

  Map<String, dynamic> toJson() {
    return {
      "cus_name": "$firstName $lastName",
      "cus_add": shippingAddress,
      "cus_city": city,
      "cus_state": "Dhaka",
      "cus_postcode": "1207",
      "cus_country": "Bangladesh",
      "cus_phone": "01785388919",
      "cus_fax": email,
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
