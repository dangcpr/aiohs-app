import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemCubit extends Cubit<List<String>> {
  AddItemCubit() : super([]);

  void addItem(String item) {
    emit([...state, item]);
  }

  void removeItem(String item) {
    emit(state.where((element) => element != item).toList());
  }

  void removeAllItem() {
    emit(List.empty());
  }
}