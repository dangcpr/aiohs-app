class AirCondPrice {
  AirCondPrice({
    this.productId = "0",
    this.unitPrice = 0,
    this.discount = 0,
    this.bringTools = 0,
    this.onPeakDate = 0,
    this.onPeakHour = 0,
    this.onHoliday = 0,
    this.onWeekend = 0,
    this.airConditioningCleanPrice,
  });
  late final String productId;
  late final int unitPrice;
  late final int discount;
  late final int bringTools;
  late final int onPeakDate;
  late final int onPeakHour;
  late final int onHoliday;
  late final int onWeekend;
  late final AirConditioningCleanPrice? airConditioningCleanPrice;

  AirCondPrice.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    unitPrice = json['unit_price'];
    discount = json['discount'];
    bringTools = json['bring_tools'];
    onPeakDate = json['on_peak_date'];
    onPeakHour = json['on_peak_hour'];
    onHoliday = json['on_holiday'];
    onWeekend = json['on_weekend'];
    airConditioningCleanPrice = AirConditioningCleanPrice.fromJson(
        json['air_conditioning_clean_price']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['unit_price'] = unitPrice;
    _data['discount'] = discount;
    _data['bring_tools'] = bringTools;
    _data['on_peak_date'] = onPeakDate;
    _data['on_peak_hour'] = onPeakHour;
    _data['on_holiday'] = onHoliday;
    _data['on_weekend'] = onWeekend;
    _data['air_conditioning_clean_price'] = airConditioningCleanPrice!.toJson();
    return _data;
  }
}

class AirConditioningCleanPrice {
  AirConditioningCleanPrice({
    required this.wall,
    required this.portable,
    required this.cassette,
    required this.floor,
    required this.builtIn,
  });
  late final Wall wall;
  late final Portable portable;
  late final Cassette cassette;
  late final Floor floor;
  late final BuiltIn builtIn;

  AirConditioningCleanPrice.fromJson(Map<String, dynamic> json) {
    wall = Wall.fromJson(json['wall']);
    portable = Portable.fromJson(json['portable']);
    cassette = Cassette.fromJson(json['cassette']);
    floor = Floor.fromJson(json['floor']);
    builtIn = BuiltIn.fromJson(json['built_in']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wall'] = wall.toJson();
    _data['portable'] = portable.toJson();
    _data['cassette'] = cassette.toJson();
    _data['floor'] = floor.toJson();
    _data['built_in'] = builtIn.toJson();
    return _data;
  }
}

class Wall {
  Wall({
    required this.bellow2HP,
    required this.above2HP,
    required this.gasRefill,
  });
  late final int bellow2HP;
  late final int above2HP;
  late final int gasRefill;

  Wall.fromJson(Map<String, dynamic> json) {
    bellow2HP = json['Bellow2HP'];
    above2HP = json['Above2HP'];
    gasRefill = json['GasRefill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Bellow2HP'] = bellow2HP;
    _data['Above2HP'] = above2HP;
    _data['GasRefill'] = gasRefill;
    return _data;
  }
}

class Portable {
  Portable({
    required this.portable,
    required this.gasRefill,
  });
  late final int portable;
  late final int gasRefill;

  Portable.fromJson(Map<String, dynamic> json) {
    portable = json['Portable'];
    gasRefill = json['GasRefill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Portable'] = portable;
    _data['GasRefill'] = gasRefill;
    return _data;
  }
}

class Cassette {
  Cassette({
    required this.bellow3HP,
    required this.above3HP,
    required this.gasRefill,
  });
  late final int bellow3HP;
  late final int above3HP;
  late final int gasRefill;

  Cassette.fromJson(Map<String, dynamic> json) {
    bellow3HP = json['Bellow3HP'];
    above3HP = json['Above3HP'];
    gasRefill = json['GasRefill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Bellow3HP'] = bellow3HP;
    _data['Above3HP'] = above3HP;
    _data['GasRefill'] = gasRefill;
    return _data;
  }
}

class Floor {
  Floor({
    required this.bellow5HP,
    required this.above5HP,
    required this.gasRefill,
  });
  late final int bellow5HP;
  late final int above5HP;
  late final int gasRefill;

  Floor.fromJson(Map<String, dynamic> json) {
    bellow5HP = json['Bellow5HP'];
    above5HP = json['Above5HP'];
    gasRefill = json['GasRefill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Bellow5HP'] = bellow5HP;
    _data['Above5HP'] = above5HP;
    _data['GasRefill'] = gasRefill;
    return _data;
  }
}

class BuiltIn {
  BuiltIn({
    required this.builtIn,
    required this.gasRefill,
  });
  late final int builtIn;
  late final int gasRefill;

  BuiltIn.fromJson(Map<String, dynamic> json) {
    builtIn = json['BuiltIn'];
    gasRefill = json['GasRefill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['BuiltIn'] = builtIn;
    _data['GasRefill'] = gasRefill;
    return _data;
  }
}
