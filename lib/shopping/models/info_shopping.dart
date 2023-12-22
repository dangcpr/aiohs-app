import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/shopping/models/product_buy.dart';

class InfoShopping {
  late AddressShopping? address;
  late int? methodOfShpping;
  late List<ProductBuy>? listItems;
  late int? price;
  late int? purchaseFee;
  late DateTime? date;
  late DateTime? time;
  late String? note;
  late String? paymentMethod;

  InfoShopping({
    this.address,
    this.methodOfShpping = 1,
    this.listItems = const [],
    this.price = 0,
    this.purchaseFee = 0,
    this.date,
    this.time,
    this.note = "",
    this.paymentMethod = 'PAYMENT_METHOD_CASH',
  });

  InfoShopping.fromJson(Map<String, dynamic> json) {
    address = AddressShopping.fromJson(json['address']);
    methodOfShpping = json['methodOfShpping'];
    listItems = json['listItems'].cast<String>();
    price = json['price'];
    date = DateTime.parse(json['date']);
    time = DateTime.parse(json['time']);
    note = json['note'];
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'methodOfShpping': methodOfShpping,
        'listItems': listItems,
        'price': price,
        'date': date!.toIso8601String(),
        'time': time!.toIso8601String(),
        'note': note,
        'paymentMethod': paymentMethod,
      };
}
