import 'dart:convert';

class InfoCleaningLongTerm {
  //late String? name;
  //late String? phone;
  late String? shortAddress;
  late String? address;
  late int duration;
  late int realDuration;
  late List<DateTime> days;
  late DateTime? time;
  late int month;
  late String? note;
  late int? price;
  late String? paymentMethod;
  late DateTime? startDay;

  InfoCleaningLongTerm({
    //this.name,
    //this.phone,
    this.shortAddress,
    this.address,
    this.duration = 2,
    this.realDuration = 2,
    required this.days,
    this.time,
    this.startDay,
    this.month = 1,
    this.note = "",
    this.price,
    this.paymentMethod = "PAYMENT_METHOD_CASH",
  });

  InfoCleaningLongTerm.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    realDuration = json['realDuration'];
    days = json['days'];
    time = DateTime.parse(json['time']);
    note = json['note'];
    month = json['month'];
    price = json['price'];
    paymentMethod = json['paymentMethod'];
    startDay = json['startDay'];
  }

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'days': jsonEncode(
            days.map((dateTime) => dateTime.toIso8601String()).toList()),
        'time': time!.toIso8601String(),
        'note': note,
        'month': month,
        'realDuration': realDuration,
        'price': price,
        'paymentMethod': paymentMethod,
        'startDay': startDay,
      };
}
