class CleaningLongTermPrice {
  late String productId;
  late int unitPrice;
  late int discount;
  late int bringTools;
  late int onPeakDate;
  late int onPeakHour;
  late int onHoliday;
  late int onWeekend;

  CleaningLongTermPrice({
    this.productId = "0",
    this.unitPrice = 0,
    this.discount = 0,
    this.bringTools = 0,
    this.onPeakDate = 0,
    this.onPeakHour = 0,
    this.onHoliday = 0,
    this.onWeekend = 0,
  });

  CleaningLongTermPrice.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    unitPrice = json['unit_price'];
    discount = json['discount'];
    bringTools = json['bring_tools'];
    onPeakDate = json['on_peak_date'];
    onPeakHour = json['on_peak_hour'];
    onHoliday = json['on_holiday'];
    onWeekend = json['on_weekend'];
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'unitPrice': unitPrice,
        'discount': discount,
        'bringTools': bringTools,
        'onPeakDate': onPeakDate,
        'onPeakHour': onPeakHour,
        'onHoliday': onHoliday,
        'onWeekend': onWeekend
      };
}
