import 'package:flutter_bloc/flutter_bloc.dart';

class UnreadNotiCubit extends Cubit<int> {
  UnreadNotiCubit() : super(0);

  void setUnreadNotiInit(int state) {
    emit(state);
  }

  void setUnreadNotiUp() {
    emit(state + 1);
  }

  void setUnreadNotiDown() {
    emit(state - 1);
  }

  void setReadNotiAll() {
    emit(0);
  }
}
