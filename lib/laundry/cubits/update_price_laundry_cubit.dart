import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePriceLaundryCubit extends Cubit<int> {
  UpdatePriceLaundryCubit() : super(0);

  void updatePriceLaundry(int priceLaundry) {
    emit(priceLaundry);
  }
}