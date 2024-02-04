class AddressShopping {
  late String? yourName;
  late String? phoneNum;
  late int? typeOfAddress;
  late String? nameAddress;
  late String? fullAddress;
  late double latCurrent;
  late double lngCurrent;
  late String city;
  late String district;
  late String ward;

  AddressShopping({
    this.yourName = "",
    this.phoneNum = "",
    this.typeOfAddress = 1,
    this.nameAddress = "",
    this.fullAddress = "",
    this.latCurrent = 0,
    this.lngCurrent = 0,
    this.city = "",
    this.district = "",
    this.ward = "",
  });

  AddressShopping.fromJson(Map<String, dynamic> json) {
    yourName = json['yourName'];
    phoneNum = json['phoneNum'];
    typeOfAddress = json['typeOfAddress'];
    nameAddress = json['nameAddress'];
    fullAddress = json['fullAddress'];
    latCurrent = json['latCurrent'];
    lngCurrent = json['lngCurrent'];
    district = json['district'];
    city = json['city'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() => {
    'yourName': yourName,
    'phoneNum': phoneNum,
    'typeOfAddress': typeOfAddress,
    'nameAddress': nameAddress,
    'fullAddress': fullAddress,
    'latCurrent': latCurrent,
    'lngCurrent': lngCurrent,
    'city': city,
    'district': district,
    'ward': ward,
  };
}