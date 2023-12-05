class ChooseTypeOfAddress {
  String value;
  String name;

  ChooseTypeOfAddress({
    required this.value,
    required this.name
  });
}

List<ChooseTypeOfAddress> chooseTypeOfAddress = [
  ChooseTypeOfAddress(value: "USER_ADDRESS_TYPE_HOME", name: "Nhà riêng"),
  ChooseTypeOfAddress(value: "USER_ADDRESS_TYPE_OFFICE", name: "Văn phòng"),
  ChooseTypeOfAddress(value: "USER_ADDRESS_TYPE_APARTMENT", name: "Chung cư"),
];