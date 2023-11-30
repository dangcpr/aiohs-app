import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfoCooking {
  //late String? name;
  //late String? phone;
  late String? shortAddress;
  late String? address;
  late int duration;
  late bool chooseMaid;
  late bool fruit;
  late String taste;
  late int bonusService;
  late double realDuration;
  late bool hasPet;
  late DateTime? date;
  late DateTime? time;
  late String? note;
  late int price;
  late String? paymentMethod;
  late String food1;
  late String food2;
  late String food3;
  late String food4;
  late int numberOfPeople;

  InfoCooking({
    //this.name,
    //this.phone,
    this.shortAddress,
    this.numberOfPeople = 1,
    this.taste = "Bắc",
    this.address,
    this.duration = 2,
    this.fruit = false,
    this.bonusService = 0,
    this.chooseMaid = false,
    this.realDuration = 2,
    this.hasPet = false,
    this.date,
    this.time,
    this.note = "",
    this.food1 = "",
    this.food2 = "",
    this.food3 = "",
    this.food4 = "",
    this.price = 0,
    this.paymentMethod = "PAYMENT_METHOD_CASH",
  });

  InfoCooking.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    taste = json['taste'];
    fruit = json['fruit'];
    chooseMaid = json['chooseMaid'];
    bonusService = json['bonusService'];
    realDuration = json['realDuration'];
    food1 = json['food1'];
    food2 = json['food2'];
    food3 = json['food3'];
    food4 = json['food4'];
    numberOfPeople = json['numberOfPeople'];
    hasPet = json['hasPet'];
    date = DateTime.parse(json['date']);
    time = DateTime.parse(json['time']);
    note = json['note'];
    price = json['price'];
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'numberOfPeople': numberOfPeople,
        'taste': taste,
        'fruit': fruit,
        'chooseMaid': chooseMaid,
        'bonusService': bonusService,
        'realDuration': realDuration,
        'food1': food1,
        'food2': food2,
        'food3': food3,
        'food4': food4,
        'hasPet': hasPet,
        'date': date!.toIso8601String(),
        'time': time!.toIso8601String(),
        'note': note,
        'price': price,
        'paymentMethod': paymentMethod,
      };
}
