import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfoAirConditioningCleaning {
  //late String? name;
  //late String? phone;
  late String? shortAddress;
  late String? address;
  late int? duration;
  late int realDuration;
  late DateTime? date;
  late DateTime? time;
  late String? note;
  late int price;
  late String? paymentMethod;
  late List<Details> details;

  InfoAirConditioningCleaning({
    //this.name,
    //this.phone,
    this.shortAddress,
    this.address,
    this.duration = 2,
    this.realDuration = 0,
    this.date,
    this.time,
    this.note = "",
    this.price = 0,
    required this.details,
    this.paymentMethod = "PAYMENT_METHOD_CASH",
  });

  InfoAirConditioningCleaning.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    realDuration = json['realDuration'];
    details =
        List.from(json['details']).map((e) => Details.fromJson(e)).toList();
    date = DateTime.parse(json['date']);
    time = DateTime.parse(json['time']);
    note = json['note'];
    price = json['price'];
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'realDuration': realDuration,
        'details': details.map((e) => e.toJson()).toList(),
        'date': date!.toIso8601String(),
        'time': time!.toIso8601String(),
        'note': note,
        'price': price,
        'paymentMethod': paymentMethod,
      };
}

class Details {
  Details({
    required this.type,
    required this.detail,
    this.amount = 1,
    this.hasGasAmount = 0,
  });
  late final String type;
  late final String detail;
  late int amount;
  late int hasGasAmount;

  Details.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    detail = json['detail'];
    amount = json['amount'];
    hasGasAmount = json['hasGasAmount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['detail'] = detail;
    _data['amount'] = amount;
    _data['hasGasAmount'] = hasGasAmount;
    return _data;
  }
}
