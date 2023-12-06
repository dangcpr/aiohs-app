import 'package:rmservice/history/models/order.dart';

class OrderResult {
  final List<Order> orders;
  final int next;

  OrderResult(this.orders, this.next);
}