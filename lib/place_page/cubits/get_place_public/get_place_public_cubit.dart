import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/place_page/controllers/place_page.dart';
import 'package:rmservice/place_page/cubits/get_place_public/get_place_public_state.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/place_page/models/rental_place_result.dart';

class GetPlacePublicCubit extends Cubit<GetPlacePublicState> {
  GetPlacePublicCubit() : super(GetPlacePublicInitial());

  List<RentalPlaceRes> rentalPlace = [];
  String next = "0";

  Future<void> getPlacePublic(
    String userCode,
    double? distance,
    String? city,
    String? district,
  ) async {
    if (next == "0" && state is GetPlacePublicLoaded) {
      return;
    }
    emit(GetPlacePublicLoading());
    try {
      
        RentalPlaceResult rentalPlaceRes = await PlacePageController()
            .getRentalPublic(userCode, next, distance, city, district);
        debugPrint(jsonEncode(rentalPlaceRes.rentalPlaceRes));
        rentalPlace.addAll(rentalPlaceRes.rentalPlaceRes);
        next = rentalPlaceRes.next;
        debugPrint(rentalPlace.length.toString());
        emit(GetPlacePublicLoaded(rentalPlace));
      
    } catch (e) {
      emit(GetPlacePublicError(e.toString()));
    }
  }

  void setInit() {
    rentalPlace = [];
    next = "0";
    emit(GetPlacePublicInitial());
  }
}
