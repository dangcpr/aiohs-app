import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';

class SaveDataShopping extends Cubit<InfoShopping> {
  SaveDataShopping() : super(InfoShopping(date: DateTime.now().add(Duration(days: 1)), time: DateTime.now()));
}