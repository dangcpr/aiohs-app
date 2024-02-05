class Report {
  late num total_rental_order;
  late num total_received_order;
  late num rental_amount;
  late num received_amount;

  Report({
    required this.total_rental_order,
    required this.total_received_order,
    required this.rental_amount,
    required this.received_amount,
  });

  Report.fromJson(Map<String, dynamic> json) {
    total_rental_order = json['total_rental_order'];
    total_received_order = json['total_received_order'];
    rental_amount = json['rental_amount'];
    received_amount = json['received_amount'];
  }

  Map<String, dynamic> toJson() => {
    'total_rental_order': total_rental_order,
    'total_received_order': total_received_order,
    'rental_amount': rental_amount,
    'received_amount': received_amount,
  };
}