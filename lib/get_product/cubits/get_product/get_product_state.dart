import 'package:rmservice/get_product/models/product.dart';

abstract class GetProductState {}

class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {
  final bool isLoading;
  GetProductLoading(this.isLoading);
}

class GetProductLoaded extends GetProductState {
  final List<Product> products;

  GetProductLoaded(this.products);
}

class GetProductError extends GetProductState {
  final String message;

  GetProductError(this.message);
}