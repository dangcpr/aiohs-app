import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_longterm/model/price_cleaning_longterm.dart';

class PriceCleaningLongTermCubit extends Cubit<CleaningLongTermPrice> {
  PriceCleaningLongTermCubit() : super(CleaningLongTermPrice());

  void setPriceCleaningLongTerm(CleaningLongTermPrice cleaningLongTermPrice) {
    emit(cleaningLongTermPrice);
  }
}
