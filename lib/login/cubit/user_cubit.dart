import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/models/user.dart';

class UserCubit extends Cubit<User> {
  UserCubit() : super(User());

  void setUser(User user) {
    emit(user);
  }
}