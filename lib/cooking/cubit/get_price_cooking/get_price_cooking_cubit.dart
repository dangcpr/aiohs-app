import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';
import 'package:rmservice/cooking/repo/cooking_repo.dart';

part 'get_price_cooking_state.dart';

class GetPriceCookingCubit extends Cubit<GetPriceCookingState> {
  GetPriceCookingCubit() : super(GetPriceCookingInitial());

  void getPriceCooking() async {
    emit(GetPriceCookingLoading());
    try {
      CookingPrice cookingPrice = await CookingRepo().getPriceCooking();
      emit(GetPriceCookingSuccess(cookingPrice));
    } catch (e) {
      emit(GetPriceCookingFailed(e.toString()));
    }
  }
}
