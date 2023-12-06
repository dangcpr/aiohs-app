class CookingHistory {
  CookingHistory({
    required this.code,
    required this.orderCooking,
    required this.detail,
  });
  late final int code;
  late final OrderCooking orderCooking;
  late final Detail detail;

  CookingHistory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    orderCooking = OrderCooking.fromJson(json['order']);
    detail = Detail.fromJson(json['detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['order'] = orderCooking.toJson();
    _data['detail'] = detail.toJson();
    return _data;
  }
}

class OrderCooking {
  OrderCooking({
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

  OrderCooking.fromJson(Map<String, dynamic> json) {
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
    required this.orderHomeCooking,
  });
  late final OrderHomeCooking orderHomeCooking;

  Detail.fromJson(Map<String, dynamic> json) {
    orderHomeCooking = OrderHomeCooking.fromJson(json['order_home_cooking']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_home_cooking'] = orderHomeCooking.toJson();
    return _data;
  }
}

class OrderHomeCooking {
  OrderHomeCooking({
    required this.numberOfPeople,
    required this.courses,
    required this.withGroceryAssistant,
    required this.groceryAssistantAmount,
    required this.note,
  });
  late final int numberOfPeople;
  late final List<String> courses;
  late final bool withGroceryAssistant;
  late final int groceryAssistantAmount;
  late final String note;

  OrderHomeCooking.fromJson(Map<String, dynamic> json) {
    numberOfPeople = json['number_of_people'];
    courses = List.castFrom<dynamic, String>(json['courses']);
    withGroceryAssistant = json['with_grocery_assistant'];
    groceryAssistantAmount = json['grocery_assistant_amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_of_people'] = numberOfPeople;
    _data['courses'] = courses;
    _data['with_grocery_assistant'] = withGroceryAssistant;
    _data['grocery_assistant_amount'] = groceryAssistantAmount;
    _data['note'] = note;
    return _data;
  }
}
