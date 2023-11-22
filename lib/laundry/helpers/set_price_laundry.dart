import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/get_product/models/product.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';

void setPriceLaundry(Product product, BuildContext context) {
  PriceLaundry priceLaundry = PriceLaundry();
  priceLaundry.clothes = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Clothes']
      .toString());
  priceLaundry.blanket = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Blanket']
      .toString());
  priceLaundry.mosquito = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Mosquito']
      .toString());
  priceLaundry.net = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Net']
      .toString());
  priceLaundry.drap = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Drap']
      .toString());
  priceLaundry.topper = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Topper']
      .toString());
  priceLaundry.pillow = int.parse(jsonDecode(product.price)['laundry_price']
          ['normal_cleaning']['Pillow']
      .toString());
  priceLaundry.comple = int.parse(jsonDecode(product.price)['laundry_price']
          ['others']['Comple']
      .toString());
  priceLaundry.vietnamDress = int.parse(
      jsonDecode(product.price)['laundry_price']['others']['VietnamDress']
          .toString());
  priceLaundry.weedingDress = int.parse(
      jsonDecode(product.price)['laundry_price']['others']['Bleaching']
          .toString());
  priceLaundry.bleaching = int.parse(jsonDecode(product.price)['laundry_price']
          ['others']['Bleaching']
      .toString());
  priceLaundry.onPeakDate =
      int.parse(jsonDecode(product.price)['on_peak_date'].toString());
  priceLaundry.onPeakHour =
      int.parse(jsonDecode(product.price)['on_peak_hour'].toString());
  priceLaundry.onHoliday =
      int.parse(jsonDecode(product.price)['on_holiday'].toString());
  priceLaundry.onWeekend =
      int.parse(jsonDecode(product.price)['on_weekend'].toString());
  priceLaundry.discount =
      int.parse(jsonDecode(product.price)['discount'].toString());
  context.read<PriceLaundryCubit>().updateInfoLaundry(priceLaundry);
  debugPrint(jsonEncode(context.read<PriceLaundryCubit>().state.toJson()));
}
