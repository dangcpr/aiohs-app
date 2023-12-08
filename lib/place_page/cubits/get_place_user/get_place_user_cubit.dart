import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/place_page/controllers/place_page.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_state.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';

class GetPlaceUserCubit extends Cubit<GetPlaceUserState> {
  GetPlaceUserCubit() : super(GetPlaceUserInitial());

  List<RentalPlaceRes> rentalPlaceRes = [];

  Future<void> getPlaceUser(String userCode) async {
    emit(GetPlaceUserLoading());
    try {
      List<RentalPlaceRes> rentalPlaceRes =
          await PlacePageController().getRental(userCode);
      debugPrint(jsonEncode(rentalPlaceRes));
      emit(GetPlaceUserLoaded(rentalPlaceRes));
    } catch (e) {
      emit(GetPlaceUserError(e.toString()));
    }
  }

  Future<void> getPlaceUserInactive(String userCode) async {
    emit(GetPlaceUserLoading());
    try {
      List<RentalPlaceRes> rentalPlaceRes =
          await PlacePageController().getRentalInactive(userCode);
      debugPrint(jsonEncode(rentalPlaceRes));
      emit(GetPlaceUserLoaded(rentalPlaceRes));
    } catch (e) {
      emit(GetPlaceUserError(e.toString()));
    }
  }

  void setInit() {
    rentalPlaceRes = [];
    emit(GetPlaceUserInitial());
  }
}
