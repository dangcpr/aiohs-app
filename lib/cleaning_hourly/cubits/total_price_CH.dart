import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPriceCHCubit extends Cubit<int> {
  TotalPriceCHCubit() : super(0);

  void setTotalPriceCH(int totalPriceCH) {
    emit(totalPriceCH);
  }
}