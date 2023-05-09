class UserDetails {
  final String firstName, lastName, shippingAddress, city, email, mobileNo;
  final int id;


  UserDetails(this.firstName, this.lastName, this.shippingAddress, this.city,
      this.email, this.mobileNo, this.id);

  factory UserDetails.fromJson(Map<String, dynamic> map) {
    return UserDetails(
      map['firstName'],
      map['lastName'],
      map['id'],
      map['shippingAddress'],
      map['email'],
      map['city'],
      map['mobileNo'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['id'] = id;
    map['shippingAddress'] = shippingAddress;
    map['email'] = email;
    map['city'] = city;
    map['mobileNo'] = mobileNo;
    return map;
  }
}
