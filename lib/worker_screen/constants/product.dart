class ProductType {
  String code;
  String name;
  ProductType({
    required this.code,
    required this.name,
  });
}

List<ProductType> productTypes = [
  ProductType(code: 'PRODUCT_CODE_UNSPECIFIED', name: 'Tất cả'),
  ProductType(code: 'PRODUCT_CODE_AIR_CONDITIONING_CLEAN', name: 'Vệ sinh máy lạnh'),
  ProductType(code: 'PRODUCT_CODE_CLEANING_DEMAND', name: 'Giúp việc theo ca'),
  ProductType(code: 'PRODUCT_CODE_CLEANING_SUBSCRIPTION', name: 'Giúp việc dài hạn'),
  ProductType(code: 'PRODUCT_CODE_GROCERY_ASSISTANT', name: 'Đi chợ hộ'),
  ProductType(code: 'PRODUCT_CODE_HOME_COOKING', name: 'Nấu ăn tại gia'),
  ProductType(code: 'PRODUCT_CODE_LAUNDRY', name: 'Giặt ủi'),
];