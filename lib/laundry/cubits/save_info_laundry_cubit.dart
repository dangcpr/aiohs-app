import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';

class SaveInfoLaundryCubit extends Cubit<InfoLaundry> {
  SaveInfoLaundryCubit()
      : super(InfoLaundry(
          sendDate: DateTime.now().add(const Duration(days: 1)),
          sendTime: DateTime.now(),
          receiveDate: DateTime.now().add(const Duration(days: 1)),
          receiveTime: DateTime.now(),
        ));

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

  void updateTotalPrice(int price) {
    InfoLaundry infoLaundry = state;
    infoLaundry.totalPrice = price;
    emit(infoLaundry);
  }

  void updateOnPeakDate(bool value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.isOnPeakDate = value;
    emit(infoLaundry);
  }

  void updateOnPeakHour(bool value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.isOnPeakHour = value;
    emit(infoLaundry);
  }

  void updateOnHoliday(bool value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.isOnHoliday = value;
    emit(infoLaundry);
  }

  void updateOnWeekend(bool value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.isOnWeekend = value;
    emit(infoLaundry);
  }

  void updateSendDate(DateTime value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.sendDate = value;
    emit(infoLaundry);
  }

  void updateSendTime(DateTime value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.sendTime = value;
    emit(infoLaundry);
  }

  void updateReceiveDate(DateTime value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.receiveDate = value;
    emit(infoLaundry);
  }

  void updateReceiveTime(DateTime value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.receiveTime = value;
    emit(infoLaundry);
  }

  void updateNote(String value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.note = value;
    emit(infoLaundry);
  }

  void updatePaymentMethod(String value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.paymentMethod = value;
    emit(infoLaundry);
  }

  void updatePriceType(String value) {
    InfoLaundry infoLaundry = state;
    infoLaundry.price_type = value;
    emit(infoLaundry);
  }
}
