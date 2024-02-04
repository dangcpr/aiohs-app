import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/worker_screen/models/address_vn.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://vapi.vnappmob.com/api',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  ),
);

class GetAddressVNController {
  Future<List<ProvinceVN>> getProvince() async {
    try {
      final response = await dio.get('/province');
      debugPrint("response pro: ${response.data}");
      if (response.statusCode == 200) {
        List<ProvinceVN> province = [];
        province = (response.data['results'] as List)
            .map((e) => ProvinceVN.fromMap(e))
            .toList();
        return province;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<DistrictVN>> getDistrict(String provinceId) async {
    try {
      final response = await dio.get('/province/district/$provinceId');
      if (response.statusCode == 200) {
        List<DistrictVN> district = [];
        district = (response.data['results'] as List)
            .map((e) => DistrictVN.fromMap(e))
            .toList();
        debugPrint(jsonEncode(district));
        return district;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
