class Address {
  late String? name;
  late String? phone;
  late String? shortAddress;
  late String? address;
  late double? latitude;
  late double? longitude;
  late String? typeOfAddress;
  late String ward;
  late String district;
  late String city;

  Address({
    this.name,
    this.phone,
    this.shortAddress,
    this.address,
    this.latitude,
    this.longitude,
    this.typeOfAddress,
    this.ward = '',
    this.district = '',
    this.city = '',
  });

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    shortAddress = json['shortAddress'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    typeOfAddress = json['typeOfAddress'];
    ward = json['ward'];
    district = json['district'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'shortAddress': shortAddress,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'typeOfAddress': typeOfAddress,
    'ward': ward,
    'district': district,
    'city': city,
  };
}