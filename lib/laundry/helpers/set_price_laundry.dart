import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';

void setPriceLaundry(PriceLaundry priceLaundry, BuildContext context) {
  context.read<PriceLaundryCubit>().updateInfoLaundry(priceLaundry);
  debugPrint(jsonEncode(context.read<PriceLaundryCubit>().state.toJson()));
}
