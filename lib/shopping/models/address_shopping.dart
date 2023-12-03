class AddressShopping {
  late String? yourName;
  late String? phoneNum;
  late int? typeOfAddress;
  late String? nameAddress;
  late String? fullAddress;
  late double latCurrent;
  late double lngCurrent;

  AddressShopping({
    this.yourName = "",
    this.phoneNum = "",
    this.typeOfAddress = 1,
    this.nameAddress = "",
    this.fullAddress = "",
    this.latCurrent = 0,
    this.lngCurrent = 0,
  });

  AddressShopping.fromJson(Map<String, dynamic> json) {
    yourName = json['yourName'];
    phoneNum = json['phoneNum'];
    typeOfAddress = json['typeOfAddress'];
    nameAddress = json['nameAddress'];
    fullAddress = json['fullAddress'];
    latCurrent = json['latCurrent'];
    lngCurrent = json['lngCurrent'];
  }

  Map<String, dynamic> toJson() => {
    'yourName': yourName,
    'phoneNum': phoneNum,
    'typeOfAddress': typeOfAddress,
    'nameAddress': nameAddress,
    'fullAddress': fullAddress,
    'latCurrent': latCurrent,
    'lngCurrent': lngCurrent,
  };
}