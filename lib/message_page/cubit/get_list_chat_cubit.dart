import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';

import '../../chat/models/chat.dart';

part 'get_list_chat_state.dart';

class GetListChatCubit extends Cubit<GetListChatState> {
  GetListChatCubit() : super(GetListChatInitial());

  void getListChat(String userCode) async {
    emit(GetListChatLoading());
    try {
      final listChatInfo = await ChatController().getListChat(userCode);
      emit(GetListChatLoaded(listChatInfo: listChatInfo));
    } catch (e) {
      emit(GetListChatFailed(error: e.toString()));
    }
  }
}
