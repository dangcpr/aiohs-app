class ShoppingPrice {
  late String productID;
  late int unitPrice;
  late int discount;
  late int onPeakDate;
  late int onPeakHour;
  late int onHoliday;
  late int onWeekend;

  ShoppingPrice({
    this.productID = "0",
    this.unitPrice = 0,
    this.discount = 0,
    this.onPeakDate = 0,
    this.onPeakHour = 0,
    this.onHoliday = 0,
    this.onWeekend = 0,
  });

  ShoppingPrice.fromJson(Map<String, dynamic> json) {
    productID = json['product_id'];
    unitPrice = json['unit_price'];
    discount = json['discount'];
    onPeakDate = json['on_peak_date'];
    onPeakHour = json['on_peak_hour'];
    onHoliday = json['on_holiday'];
    onWeekend = json['on_weekend'];
  }

  Map<String, dynamic> toJson() => {
        'productID': productID,
        'unitPrice': unitPrice,
        'discount': discount,
        'onPeakDate': onPeakDate,
        'onPeakHour': onPeakHour,
        'onHoliday': onHoliday,
        'onWeekend': onWeekend
      };
}
