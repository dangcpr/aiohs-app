import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';

class SaveInfoLaundryCubit extends Cubit<InfoLaundry> {
  SaveInfoLaundryCubit() : super(InfoLaundry());

  void updateInfoLaundry(InfoLaundry infoLaundry) {
    emit(infoLaundry);
  }

  void updateClothes(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.clothes = value;
    emit(infoLaundry);
  }

  void updateBlanket(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.blanket = value;
    emit(infoLaundry);
  }

  void updateMosquito(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.mosquito = value;
    emit(infoLaundry);
  }

  void updateNet(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.net = value;
    emit(infoLaundry);
  }

  void updateDrap(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.drap = value;
    emit(infoLaundry);
  }

  void updateTopper(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.topper = value;
    emit(infoLaundry);
  }

  void updatePillow(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.pillow = value;
    emit(infoLaundry);
  }

  void updateComple(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.comple = value;
    emit(infoLaundry);
  }

  void updateVietnamDress(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.vietnamDress = value;
    emit(infoLaundry);
  }

  void updateWeedingDress(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.weedingDress = value;
    emit(infoLaundry);
  }

  void updateBleaching(int value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.bleaching = value;
    emit(infoLaundry);
  }

  void updateTotalPrice(PriceLaundry priceLaundry) {
    InfoLaundry infoLaundry = state;
    infoLaundry.totalPrice = infoLaundry.clothes * (priceLaundry.clothes ?? 0) +
        infoLaundry.blanket * (priceLaundry.blanket ?? 0) +
        infoLaundry.mosquito * (priceLaundry.mosquito ?? 0) +
        infoLaundry.net * (priceLaundry.net ?? 0) +
        infoLaundry.drap * (priceLaundry.drap ?? 0) +
        infoLaundry.topper * (priceLaundry.topper ?? 0) +
        infoLaundry.pillow * (priceLaundry.pillow ?? 0) +
        infoLaundry.comple * (priceLaundry.comple ?? 0) +
        infoLaundry.vietnamDress * (priceLaundry.vietnamDress ?? 0) +
        infoLaundry.weedingDress * (priceLaundry.weedingDress ?? 0) +
        infoLaundry.bleaching * (priceLaundry.bleaching ?? 0);
    emit(infoLaundry);
  }
}
