class CleaningHourlyHistory {
  late String id;
  late String code;
  late String renter_code;
  late String renter_name;
  late String maid_code;
  late String maid_name;
  late String product_code;
  late String product_name;
  late int order_amount;
  late String payment_method;
  late String payment_method_display;
  late String status;
  late String status_display;
  late String working_hour;
  late String working_date;
  late String working_address;
  late String created_at;
  late String updated_at;
  late int duration;
  late bool house_with_pet;
  late bool with_home_cooking;
  late bool with_laundry;
  late String note;

  CleaningHourlyHistory({
    required this.id,
    required this.code,
    required this.renter_code,
    required this.renter_name,
    required this.maid_code,
    required this.maid_name,
    required this.product_code,
    required this.product_name,
    required this.order_amount,
    required this.payment_method,
    required this.payment_method_display,
    required this.status,
    required this.status_display,
    required this.working_hour,
    required this.working_date,
    required this.working_address,
    required this.created_at,
    required this.updated_at,
    required this.duration,
    required this.house_with_pet,
    required this.with_home_cooking,
    required this.with_laundry,
    required this.note
  });

  CleaningHourlyHistory.fromJson(Map<String, dynamic> json) {
    id = json['order']['id'];
    code = json['order']['code'];
    renter_code = json['order']['renter_code'];
    renter_name = json['order']['renter_name'];
    maid_code = json['order']['maid_code'];
    maid_name = json['order']['maid_name'];
    product_code = json['order']['product_code'];
    product_name = json['order']['product_name'];
    order_amount = json['order']['order_amount'];
    payment_method = json['order']['payment_method'];
    payment_method_display = json['order']['payment_method_display'];
    status = json['order']['status'];
    status_display = json['order']['status_display'];
    working_hour = json['order']['working_hour'];
    working_date = json['order']['working_date'];
    working_address = json['order']['working_address'];
    created_at = json['order']['created_at'];
    updated_at = json['order']['updated_at'];
    duration = json['detail']['order_cleaning_demand']['duration'];
    house_with_pet = json['detail']['order_cleaning_demand']['house_with_pet'];
    with_home_cooking = json['detail']['order_cleaning_demand']['with_home_cooking'];
    with_laundry = json['detail']['order_cleaning_demand']['with_laundry'];
    note = json['detail']['order_cleaning_demand']['note'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'renter_code': renter_code,
    'renter_name': renter_name,
    'maid_code': maid_code,
    'maid_name': maid_name,
    'product_code': product_code,
    'product_name': product_name,
    'order_amount': order_amount,
    'payment_method': payment_method,
    'payment_method_display': payment_method_display,
    'status': status,
    'status_display': status_display,
    'working_hour': working_hour,
    'working_date': working_date,
    'working_address': working_address,
    'created_at': created_at,
    'updated_at': updated_at,
    'duration': duration,
    'house_with_pet': house_with_pet,
    'with_home_cooking': with_home_cooking,
    'with_laundry': with_laundry,
    'note': note
  };
}