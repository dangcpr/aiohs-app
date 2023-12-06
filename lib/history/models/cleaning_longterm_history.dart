class CleaningLongTermHistory {
  CleaningLongTermHistory({
    required this.orderCleaningLongTerm,
    required this.detail,
  });
  late final OrderCleaningLongTerm orderCleaningLongTerm;
  late final Detail detail;

  CleaningLongTermHistory.fromJson(Map<String, dynamic> json) {
    orderCleaningLongTerm = OrderCleaningLongTerm.fromJson(json['order']);
    detail = Detail.fromJson(json['detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order'] = orderCleaningLongTerm.toJson();
    _data['detail'] = detail.toJson();
    return _data;
  }
}

class OrderCleaningLongTerm {
  OrderCleaningLongTerm({
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

  OrderCleaningLongTerm.fromJson(Map<String, dynamic> json) {
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
    required this.orderCleaningSubscription,
  });
  late final OrderCleaningSubscription orderCleaningSubscription;

  Detail.fromJson(Map<String, dynamic> json) {
    orderCleaningSubscription =
        OrderCleaningSubscription.fromJson(json['order_cleaning_subscription']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_cleaning_subscription'] = orderCleaningSubscription.toJson();
    return _data;
  }
}

class OrderCleaningSubscription {
  OrderCleaningSubscription({
    required this.durationPerDay,
    required this.dates,
    required this.numberOfMonth,
    required this.note,
  });
  late final int durationPerDay;
  late final List<String> dates;
  late final int numberOfMonth;
  late final String note;

  OrderCleaningSubscription.fromJson(Map<String, dynamic> json) {
    durationPerDay = json['duration_per_day'];
    dates = List.castFrom<dynamic, String>(json['dates']);
    numberOfMonth = json['number_of_month'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['duration_per_day'] = durationPerDay;
    _data['dates'] = dates;
    _data['number_of_month'] = numberOfMonth;
    _data['note'] = note;
    return _data;
  }
}
