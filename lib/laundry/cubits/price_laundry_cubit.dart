import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';

class PriceLaundryCubit extends Cubit<PriceLaundry> {
  PriceLaundryCubit() : super(PriceLaundry());

  void updateInfoLaundry(PriceLaundry priceLaundry) {
    emit(priceLaundry);
  }
}