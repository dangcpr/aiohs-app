abstract class GetProductState {}

class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {
  final bool isLoading;
  GetProductLoading(this.isLoading);
}

class GetProductLoaded extends GetProductState {
  final String products;

  GetProductLoaded(this.products);
}

class GetProductError extends GetProductState {
  final String message;

  GetProductError(this.message);
}