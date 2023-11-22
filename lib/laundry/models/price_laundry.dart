class PriceLaundry {
  int? clothes;
  int? blanket;
  int? mosquito;
  int? net;
  int? drap;
  int? topper;
  int? pillow;
  int? comple;
  int? vietnamDress;
  int? weedingDress;
  int? bleaching;
  int? onPeakDate;
  int? onPeakHour;
  int? onHoliday;
  int? onWeekend;
  int? discount;

  PriceLaundry({
    this.clothes,
    this.blanket,
    this.mosquito,
    this.net,
    this.drap,
    this.topper,
    this.pillow,
    this.comple,
    this.vietnamDress,
    this.weedingDress,
    this.bleaching,
    this.onPeakDate,
    this.onPeakHour,
    this.onHoliday,
    this.onWeekend,
    this.discount
  });

  Map<String, dynamic> toJson() => {
    'clothes': clothes,
    'blanket': blanket,
    'mosquito': mosquito,
    'net': net,
    'drap': drap,
    'topper': topper,
    'pillow': pillow,
    'comple': comple,
    'vietnamDress': vietnamDress,
    'weedingDress': weedingDress,
    'bleaching': bleaching,
    'onPeakDate': onPeakDate,
    'onPeakHour': onPeakHour,
    'onHoliday': onHoliday,
    'onWeekend': onWeekend,
    'discount': discount
  };
}