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

  PriceLaundry.fromJson(Map<String, dynamic> json) {
    clothes = json['laundry_price']['normal_cleaning']['Clothes'];
    blanket = json['laundry_price']['normal_cleaning']['Blanket'];
    mosquito = json['laundry_price']['normal_cleaning']['Mosquito'];
    net = json['laundry_price']['normal_cleaning']['Net'];
    drap = json['laundry_price']['normal_cleaning']['Drap'];
    topper = json['laundry_price']['normal_cleaning']['Topper'];
    pillow = json['laundry_price']['normal_cleaning']['Pillow'];
    comple = json['laundry_price']['others']['Comple'];
    vietnamDress = json['laundry_price']['others']['VietnamDress'];
    weedingDress = json['laundry_price']['others']['WeddingDress'];
    bleaching = json['laundry_price']['others']['Bleaching'];
    onPeakDate = json['on_peak_date'];
    onPeakHour = json['on_peak_hour'];
    onHoliday = json['on_holiday'];
    onWeekend = json['on_weekend'];
    discount = json['discount'];
  }

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