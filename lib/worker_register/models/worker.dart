import 'dart:io';

import 'package:rmservice/worker_register/constants/list_work.dart';

class Worker {
  String userCode;
  String id;
  String phone;
  List<Job> job;
  double latitude;
  double longitude;
  String address;
  File? idF;
  File? idB;

  Worker({
    this.userCode = "",
    this.id = "",
    this.phone = "",
    this.job = const [],
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.idF,
    this.idB,
  });

  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'id': id,
      'phone': phone,
      'job': job.map((e) => e.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'idF': idF,
      'idB': idB,
    };
  }
}