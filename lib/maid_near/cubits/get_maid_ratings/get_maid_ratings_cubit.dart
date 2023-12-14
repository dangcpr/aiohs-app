import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/maid_near/controllers/get_maid_info.dart';
import 'package:rmservice/maid_near/cubits/get_maid_ratings/get_maid_ratings_state.dart';
import 'package:rmservice/maid_near/models/maid_rating.dart';

class GetMaidRatingsCubit extends Cubit<GetMaidRatingsState> {
  GetMaidRatingsCubit() : super(GetMaidRatingsInitial());

  String next = "0";
  List<MaidRatingRes> listRatingRes = [];

  Future<void> getMaidRatings(String userCode, String maidCode, int limit) async {
    emit(GetMaidRatingsLoading());
    try {
      if (next == "0" && state is GetMaidRatingsSuccess) {
        return;
      }
      final listRating = await MaidInfoController().getRatings(userCode, maidCode, limit, next);
      next = listRating.next;
      listRatingRes.addAll(listRating.listMaidRating);
      emit(GetMaidRatingsSuccess(listRatingRes));
    } catch (e) {
      emit(GetMaidRatingsError(e.toString()));
    }
  }

  void initState() {
    listRatingRes.clear();
    next = "0";
    emit(GetMaidRatingsInitial());
  }
}