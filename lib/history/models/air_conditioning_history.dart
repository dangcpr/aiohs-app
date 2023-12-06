class CleaningAirCondHistory {
  CleaningAirCondHistory({
    required this.code,
    required this.orderAirCondHistory,
    required this.detail,
  });
  late final int code;
  late final OrderAirCondHistory orderAirCondHistory;
  late final Detail detail;

  CleaningAirCondHistory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    orderAirCondHistory = OrderAirCondHistory.fromJson(json['order']);
    detail = Detail.fromJson(json['detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['order'] = orderAirCondHistory.toJson();
    _data['detail'] = detail.toJson();
    return _data;
  }
}

class OrderAirCondHistory {
  OrderAirCondHistory({
    required this.id,
    required this.code,
    required this.renterCode,
    required this.renterName,
    required this.agentName,
    required this.agentPhone,
    required this.maidCode,
    required this.maidName,
    required this.productCode,
    required this.productName,
    required this.orderAmount,
    required this.paymentMethod,
    required this.paymentMethodDisplay,
    required this.status,
    required this.statusDisplay,
    required this.workingHour,
    required this.workingDate,
    required this.workingAddress,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String code;
  late final String renterCode;
  late final String renterName;
  late final String agentName;
  late final String agentPhone;
  late final String maidCode;
  late final String maidName;
  late final String productCode;
  late final String productName;
  late final int orderAmount;
  late final String paymentMethod;
  late final String paymentMethodDisplay;
  late final String status;
  late final String statusDisplay;
  late final String workingHour;
  late final String workingDate;
  late final String workingAddress;
  late final double longitude;
  late final double latitude;
  late final String createdAt;
  late final String updatedAt;

  OrderAirCondHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    renterCode = json['renter_code'];
    renterName = json['renter_name'];
    agentName = json['agent_name'];
    agentPhone = json['agent_phone'];
    maidCode = json['maid_code'];
    maidName = json['maid_name'];
    productCode = json['product_code'];
    productName = json['product_name'];
    orderAmount = json['order_amount'];
    paymentMethod = json['payment_method'];
    paymentMethodDisplay = json['payment_method_display'];
    status = json['status'];
    statusDisplay = json['status_display'];
    workingHour = json['working_hour'];
    workingDate = json['working_date'];
    workingAddress = json['working_address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['renter_code'] = renterCode;
    _data['renter_name'] = renterName;
    _data['agent_name'] = agentName;
    _data['agent_phone'] = agentPhone;
    _data['maid_code'] = maidCode;
    _data['maid_name'] = maidName;
    _data['product_code'] = productCode;
    _data['product_name'] = productName;
    _data['order_amount'] = orderAmount;
    _data['payment_method'] = paymentMethod;
    _data['payment_method_display'] = paymentMethodDisplay;
    _data['status'] = status;
    _data['status_display'] = statusDisplay;
    _data['working_hour'] = workingHour;
    _data['working_date'] = workingDate;
    _data['working_address'] = workingAddress;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Detail {
  Detail({
    required this.orderAirConditioningClean,
  });
  late final OrderAirConditioningClean orderAirConditioningClean;

  Detail.fromJson(Map<String, dynamic> json) {
    orderAirConditioningClean = OrderAirConditioningClean.fromJson(
        json['order_air_conditioning_clean']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_air_conditioning_clean'] = orderAirConditioningClean.toJson();
    return _data;
  }
}

class OrderAirConditioningClean {
  OrderAirConditioningClean({
    required this.note,
    required this.wall,
    required this.portable,
    required this.cassette,
    required this.floor,
    required this.builtIn,
  });
  late final String note;
  late final Wall wall;
  late final Portable portable;
  late final Cassette cassette;
  late final Floor floor;
  late final BuiltIn builtIn;

  OrderAirConditioningClean.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    wall = Wall.fromJson(json['wall']);
    portable = Portable.fromJson(json['portable']);
    cassette = Cassette.fromJson(json['cassette']);
    floor = Floor.fromJson(json['floor']);
    builtIn = BuiltIn.fromJson(json['built_in']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['note'] = note;
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
    required this.numberBellow_2hp,
    required this.numberAbove_2hp,
    required this.gasRefillBellow_2hp,
    required this.gasRefillAbove_2hp,
  });
  late final int numberBellow_2hp;
  late final int numberAbove_2hp;
  late final int gasRefillBellow_2hp;
  late final int gasRefillAbove_2hp;

  Wall.fromJson(Map<String, dynamic> json) {
    numberBellow_2hp = json['number_bellow_2hp'];
    numberAbove_2hp = json['number_above_2hp'];
    gasRefillBellow_2hp = json['gas_refill_bellow_2hp'];
    gasRefillAbove_2hp = json['gas_refill_above_2hp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_bellow_2hp'] = numberBellow_2hp;
    _data['number_above_2hp'] = numberAbove_2hp;
    _data['gas_refill_bellow_2hp'] = gasRefillBellow_2hp;
    _data['gas_refill_above_2hp'] = gasRefillAbove_2hp;
    return _data;
  }
}

class Portable {
  Portable({
    required this.numberAc,
    required this.gasRefill,
  });
  late final int numberAc;
  late final int gasRefill;

  Portable.fromJson(Map<String, dynamic> json) {
    numberAc = json['number_ac'];
    gasRefill = json['gas_refill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_ac'] = numberAc;
    _data['gas_refill'] = gasRefill;
    return _data;
  }
}

class Cassette {
  Cassette({
    required this.numberBellow_3hp,
    required this.numberAbove_3hp,
    required this.gasRefillBellow_3hp,
    required this.gasRefillAbove_3hp,
  });
  late final int numberBellow_3hp;
  late final int numberAbove_3hp;
  late final int gasRefillBellow_3hp;
  late final int gasRefillAbove_3hp;

  Cassette.fromJson(Map<String, dynamic> json) {
    numberBellow_3hp = json['number_bellow_3hp'];
    numberAbove_3hp = json['number_above_3hp'];
    gasRefillBellow_3hp = json['gas_refill_bellow_3hp'];
    gasRefillAbove_3hp = json['gas_refill_above_3hp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_bellow_3hp'] = numberBellow_3hp;
    _data['number_above_3hp'] = numberAbove_3hp;
    _data['gas_refill_bellow_3hp'] = gasRefillBellow_3hp;
    _data['gas_refill_above_3hp'] = gasRefillAbove_3hp;
    return _data;
  }
}

class Floor {
  Floor({
    required this.numberBellow_5hp,
    required this.numberAbove_5hp,
    required this.gasRefillBellow_5hp,
    required this.gasRefillAbove_5hp,
  });
  late final int numberBellow_5hp;
  late final int numberAbove_5hp;
  late final int gasRefillBellow_5hp;
  late final int gasRefillAbove_5hp;

  Floor.fromJson(Map<String, dynamic> json) {
    numberBellow_5hp = json['number_bellow_5hp'];
    numberAbove_5hp = json['number_above_5hp'];
    gasRefillBellow_5hp = json['gas_refill_bellow_5hp'];
    gasRefillAbove_5hp = json['gas_refill_above_5hp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_bellow_5hp'] = numberBellow_5hp;
    _data['number_above_5hp'] = numberAbove_5hp;
    _data['gas_refill_bellow_5hp'] = gasRefillBellow_5hp;
    _data['gas_refill_above_5hp'] = gasRefillAbove_5hp;
    return _data;
  }
}

class BuiltIn {
  BuiltIn({
    required this.numberAc,
    required this.gasRefill,
  });
  late final int numberAc;
  late final int gasRefill;

  BuiltIn.fromJson(Map<String, dynamic> json) {
    numberAc = json['number_ac'];
    gasRefill = json['gas_refill'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_ac'] = numberAc;
    _data['gas_refill'] = gasRefill;
    return _data;
  }
}
