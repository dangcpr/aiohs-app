class Address {
  late String? name;
  late String? phone;
  late String? shortAddress;
  late String? address;
  late String? typeOfAddress;

  Address({
    this.name,
    this.phone,
    this.shortAddress,
    this.address,
    this.typeOfAddress
  });

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    shortAddress = json['shortAddress'];
    address = json['address'];
    typeOfAddress = json['typeOfAddress'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'shortAddress': shortAddress,
    'address': address,
    'typeOfAddress': typeOfAddress
  };
}