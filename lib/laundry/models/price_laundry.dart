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
  int? clothes_k;
  int? blanket_k;
  int? mosquito_k;
  int? net_k;
  int? drap_k;
  int? topper_k;
  int? pillow_k;
  int? comple_k;
  int? vietnamDress_k;
  int? weedingDress_k;
  int? bleaching_k;
  int? onPeakDate;
  int? onPeakHour;
  int? onHoliday;
  int? onWeekend;
  int? discount;

  PriceLaundry(
      {this.clothes,
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
      this.discount});

  PriceLaundry.fromJson(Map<String, dynamic> json) {
    clothes =
        json['laundry_price']['price_clothes']['normal_cleaning']['Clothes'];
    blanket =
        json['laundry_price']['price_clothes']['normal_cleaning']['Blanket'];
    mosquito =
        json['laundry_price']['price_clothes']['normal_cleaning']['Mosquito'];
    net = json['laundry_price']['price_clothes']['normal_cleaning']['Net'];
    drap = json['laundry_price']['price_clothes']['normal_cleaning']['Drap'];
    topper =
        json['laundry_price']['price_clothes']['normal_cleaning']['Topper'];
    pillow =
        json['laundry_price']['price_clothes']['normal_cleaning']['Pillow'];
    comple = json['laundry_price']['price_clothes']['others']['Comple'];
    vietnamDress =
        json['laundry_price']['price_clothes']['others']['VietnamDress'];
    weedingDress =
        json['laundry_price']['price_clothes']['others']['WeddingDress'];
    bleaching = json['laundry_price']['price_clothes']['others']['Bleaching'];
    clothes_k =
        json['laundry_price']['price_kg']['normal_cleaning']['Clothes'];
    blanket_k =
        json['laundry_price']['price_kg']['normal_cleaning']['Blanket'];
    mosquito_k =
        json['laundry_price']['price_kg']['normal_cleaning']['Mosquito'];
    net_k = json['laundry_price']['price_kg']['normal_cleaning']['Net'];
    drap_k = json['laundry_price']['price_kg']['normal_cleaning']['Drap'];
    topper_k =
        json['laundry_price']['price_kg']['normal_cleaning']['Topper'];
    pillow_k =
        json['laundry_price']['price_kg']['normal_cleaning']['Pillow'];
    comple_k = json['laundry_price']['price_kg']['others']['Comple'];
    vietnamDress_k =
        json['laundry_price']['price_kg']['others']['VietnamDress'];
    weedingDress_k =
        json['laundry_price']['price_kg']['others']['WeddingDress'];
    bleaching_k = json['laundry_price']['price_kg']['others']['Bleaching'];
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
        'clothes_k': clothes_k,
        'blanket_k': blanket_k,
        'mosquito_k': mosquito_k,
        'net_k': net_k,
        'drap_k': drap_k,
        'topper_k': topper_k,
        'pillow_k': pillow_k,
        'comple_k': comple_k,
        'vietnamDress_k': vietnamDress_k,
        'weedingDress_k': weedingDress_k,
        'bleaching_k': bleaching_k,
        'onPeakDate': onPeakDate,
        'onPeakHour': onPeakHour,
        'onHoliday': onHoliday,
        'onWeekend': onWeekend,
        'discount': discount
      };
}
