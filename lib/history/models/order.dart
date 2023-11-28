class Order {
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

  Order({
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
    required this.updated_at
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    renter_code = json['renter_code'];
    renter_name = json['renter_name'];
    maid_code = json['maid_code'];
    maid_name = json['maid_name'];
    product_code = json['product_code'];
    product_name = json['product_name'];
    order_amount = json['order_amount'];
    payment_method = json['payment_method'];
    payment_method_display = json['payment_method_display'];
    status = json['status'];
    status_display = json['status_display'];
    working_hour = json['working_hour'];
    working_date = json['working_date'];
    working_address = json['working_address'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
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
    'updated_at': updated_at
  };
}