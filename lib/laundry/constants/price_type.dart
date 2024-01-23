class PriceType {
  late String name;
  late String code;

  PriceType({required this.name, required this.code});
}

List<PriceType> priceTypes = [
  PriceType(name: 'Ki-lô-gam', code: 'LAUNDRY_PRICE_TYPE_KG'),
  PriceType(name: 'Bộ', code: 'LAUNDRY_PRICE_TYPE_CLOTHES'),
];
