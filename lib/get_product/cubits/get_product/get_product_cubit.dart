import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/get_product/controllers/get_product.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_state.dart';
import 'package:rmservice/get_product/models/product.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(GetProductInitial());

  void getProduct() async {
    emit(GetProductLoading(true));

    print('get product loading');
    try {
      List<Product> products = await GetProductController().getProducts();
      print(jsonEncode(products));
      emit(GetProductLoaded(products));
    } catch (e) {
      emit(GetProductError(e.toString()));
    }
  }

  void reset() {
    emit(GetProductInitial());
  }

  void loading() {
    emit(GetProductLoading(true));
  }
}
