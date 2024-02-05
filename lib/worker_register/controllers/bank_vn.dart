import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/worker_register/models/bank_vn.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "https://api.vietqr.io/v2/banks",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  ),
);

class BankVNController {
  Future<List<BankVN>> getBankVN() async {
    try {
      var response = await dio.get(
        '/',
      );
      
      List<BankVN> listBankVN = [];
      if (response.data['code'] == "00") {
        debugPrint(response.data.toString());
        listBankVN = (response.data['data'] as List)
            .map((e) => BankVN.fromJson(e))
            .toList();
      } else {
        return [];
      }
      return listBankVN;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
