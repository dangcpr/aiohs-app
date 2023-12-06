import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/model/air_conditioning_cleaning_price.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';

class SaveInfoAirConditioningCleaningCubit
    extends Cubit<InfoAirConditioningCleaning> {
  SaveInfoAirConditioningCleaningCubit()
      : super(InfoAirConditioningCleaning(
            time: DateTime.now(),
            details: [],
            date: DateTime.now().add(Duration(days: 1))));

  void setInitial() {
    InfoAirConditioningCleaning infoAirConditioningCleaning =
        new InfoAirConditioningCleaning(
            time: DateTime.now(),
            details: [],
            date: DateTime.now().add(Duration(days: 1)));
    emit(infoAirConditioningCleaning);
  }

  void setInfoAirConditioningCleaning(
      InfoAirConditioningCleaning infoAirConditioningCleaning) {
    emit(infoAirConditioningCleaning);
  }

  void printListItem() {
    for (int i = 0; i < state.details.length; i++) {
      print('------- Item $i -------');
      print(state.details[i].type);
      print(state.details[i].detail);
      print(state.details[i].amount);
      print(state.details[i].hasGasAmount);
      print('------- End Item $i -------');
    }
  }

  void printListItem2(List<Details> details) {
    for (int i = 0; i < details.length; i++) {
      print('------- Item $i -------');
      print(details[i].type);
      print(details[i].detail);
      print(details[i].amount);
      print(details[i].hasGasAmount);
      print('------- End Item $i -------');
    }
  }

  void addDetail(Details detail) {
    // InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    state.details.add(detail);
    printListItem();
    emit(state);
  }

  Details createNewDetail({required String type, required String info}) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    Details detail = Details(type: type, detail: info);
    int index = checkIndex(detail, state.details);
    if (index != -1) {
      return state.details[index];
    } else
      infoAirConditioningCleaning.details.add(detail);
    emit(infoAirConditioningCleaning);
    printListItem();

    return detail;
  }

  int checkIndex(Details detail, List<Details> details) {
    int i = 0;
    for (i; i < details.length; i++) {
      if (detail.detail == details[i].detail) {
        return i;
      }
    }
    return -1;
  }

  void deleteDuplicateItem() {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    for (int i = 0; i < state.details.length; i++) {
      int index = checkIndex(state.details[i], state.details);
      if (index != -1) {
        removeDetail(state.details[index]);
      }
    }

    printListItem();

    emit(state);
  }

  void removeDetail(Details detail) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    int index = checkIndex(detail, state.details);
    if (index != -1) {
      infoAirConditioningCleaning.details.removeAt(index);
    }
    printListItem();

    emit(infoAirConditioningCleaning);
  }

  int totalPrice(AirCondPrice airCondPrice) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    var price = airCondPrice.airConditioningCleanPrice;
    var infoDetails = infoAirConditioningCleaning.details;
    int totalPrice = 0;
    int totalAmount = 0;
    for (int i = 0; i < infoDetails.length; i++) {
      var infoDetailsIndex = infoDetails[i];
      totalAmount += infoDetailsIndex.amount;
      if (infoDetails[i].type == 'Build_in') {
        totalPrice += price!.builtIn.builtIn * infoDetailsIndex.amount;
        if (infoDetailsIndex.hasGasAmount == true) {
          totalPrice += price.builtIn.gasRefill;
        }
      }
      if (infoDetails[i].type == 'Wall') {
        if (infoDetailsIndex.detail == 'Above 2HP') {
          totalPrice += price!.wall.above2HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.detail == 'Below 2HP') {
          totalPrice += price!.wall.bellow2HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.hasGasAmount == true) {
          totalPrice += price!.wall.gasRefill;
        }
      }

      if (infoDetails[i].type == 'Floor') {
        if (infoDetailsIndex.detail == 'Above 2HP') {
          totalPrice += price!.floor.above5HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.detail == 'Below 2HP') {
          totalPrice += price!.floor.bellow5HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.hasGasAmount == true) {
          totalPrice += price!.floor.gasRefill;
        }
      }

      if (infoDetails[i].type == 'Portable') {
        totalPrice += price!.portable.portable * infoDetailsIndex.amount;
        if (infoDetailsIndex.hasGasAmount == true) {
          totalPrice += price.portable.gasRefill;
        }
      }

      if (infoDetails[i].type == 'Cassette') {
        if (infoDetailsIndex.detail == 'Above 3HP') {
          totalPrice += price!.cassette.above3HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.detail == 'Below 3HP') {
          totalPrice += price!.cassette.bellow3HP * infoDetailsIndex.amount;
        }
        if (infoDetailsIndex.hasGasAmount == true) {
          totalPrice += price!.cassette.gasRefill;
        }
      }
    }
    print('Total Price is: $totalPrice}');
    state.price = totalPrice;
    print('Total Price from model is: ${state.price}');
    state.realDuration = totalAmount;
    emit(state);
    return totalPrice;
  }

  void confuseListDetails() {
    List<Details> detailesTemp = [
      Details(type: "Wall", detail: "Below 2HP", amount: 0),
      Details(type: "Wall", detail: "Above 2HP", amount: 0),
      Details(type: "Portable", detail: "Portable", amount: 0),
      Details(type: "Cassette", detail: "Below 3HP", amount: 0),
      Details(type: "Cassette", detail: "Above 3HP", amount: 0),
      Details(type: "Floor", detail: "Below 5HP", amount: 0),
      Details(type: "Floor", detail: "Above 5HP", amount: 0),
      Details(type: "Built_in", detail: "Build_in", amount: 0),
    ];
    for (int i = 0; i < state.details.length; i++) {
      var detailIndex = state.details[i];
      if (detailIndex.type == "Wall") {
        if (detailIndex.detail == "Below 2HP") {
          detailesTemp[0].amount = detailIndex.amount;
          detailesTemp[0].hasGasAmount = detailIndex.hasGasAmount;
        }
        if (detailIndex.detail == "Above 2HP") {
          detailesTemp[1].amount = detailIndex.amount;
          detailesTemp[1].hasGasAmount = detailIndex.hasGasAmount;
        }
      }
      if (detailIndex.detail == "Portable") {
        detailesTemp[2].amount = detailIndex.amount;
        detailesTemp[2].hasGasAmount = detailIndex.hasGasAmount;
      }
      if (detailIndex.type == "Cassette") {
        if (detailIndex.detail == "Below 3HP") {
          detailesTemp[3].amount = detailIndex.amount;
          detailesTemp[3].hasGasAmount = detailIndex.hasGasAmount;
        }
        if (detailIndex.detail == "Above 3HP") {
          detailesTemp[4].amount = detailIndex.amount;
          detailesTemp[4].hasGasAmount = detailIndex.hasGasAmount;
        }
      }
      if (detailIndex.type == "Floor") {
        if (detailIndex.detail == "Below 5HP") {
          detailesTemp[5].amount = detailIndex.amount;
          detailesTemp[5].hasGasAmount = detailIndex.hasGasAmount;
        }
        if (detailIndex.detail == "Above 5HP") {
          detailesTemp[6].amount = detailIndex.amount;
          detailesTemp[6].hasGasAmount = detailIndex.hasGasAmount;
        }
      }
      if (detailIndex.detail == "Built_in") {
        detailesTemp[7].amount = detailIndex.amount;
        detailesTemp[7].hasGasAmount = detailIndex.hasGasAmount;
      }
    }
    state.details = detailesTemp;
    printListItem();
    emit(state);
  }

  void updatePaymentMethod(String paymentMethod) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    infoAirConditioningCleaning.paymentMethod = paymentMethod;
    emit(infoAirConditioningCleaning);
  }
}
