class AddressShopping {
  late String? yourName;
  late String? phoneNum;
  late int? typeOfAddress;
  late String? nameAddress;
  late String? fullAddress;

  AddressShopping({
    this.yourName = "",
    this.phoneNum = "",
    this.typeOfAddress = 1,
    this.nameAddress = "",
    this.fullAddress = ""
  });

  AddressShopping.fromJson(Map<String, dynamic> json) {
    yourName = json['yourName'];
    phoneNum = json['phoneNum'];
    typeOfAddress = json['typeOfAddress'];
    nameAddress = json['nameAddress'];
    fullAddress = json['fullAddress'];
  }

  Map<String, dynamic> toJson() => {
    'yourName': yourName,
    'phoneNum': phoneNum,
    'typeOfAddress': typeOfAddress,
    'nameAddress': nameAddress,
    'fullAddress': fullAddress
  };
}