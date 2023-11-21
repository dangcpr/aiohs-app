import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_cubit.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_state.dart';
import 'package:rmservice/get_product/models/product.dart';

class LaundryStep1Screen extends StatefulWidget {
  const LaundryStep1Screen({super.key});

  @override
  State<LaundryStep1Screen> createState() => _LaundryStep1ScreenState();
}

class _LaundryStep1ScreenState extends State<LaundryStep1Screen> {
  @override
  Widget build(BuildContext context) {
    Product product;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GetProductCubit, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoaded) {
            product = state.products
                .firstWhere((element) => element.code == 'LAUNDRY');
            String normalPrice = jsonDecode(product.price)['laundry_price']['normal_cleaning'].toString();
            int clothes = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Clothes'].toString());
            int blanket = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Blanket'].toString());
            int mosquito = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Mosquito'].toString());
            int net = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Net'].toString());
            int drap = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Drap'].toString());
            int topper = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Topper'].toString());
            int pillow = int.parse(jsonDecode(product.price)['laundry_price']['normal_cleaning']['Pillow'].toString());


            return Text(normalPrice + '   ' + clothes.toString());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
