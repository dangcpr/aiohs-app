import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/cubits/get_chat_detail/get_chat_detail_state.dart';
import 'package:rmservice/chat/models/chat_detail.dart';

class GetChatDetailCubit extends Cubit<GetChatDetailState> {
  GetChatDetailCubit() : super(GetChatDetailInitial());
  int next = 0;

  Future<List<Messages>> getChatDetail(String roomId) async {
    emit(GetChatDetailLoading());
    try {
      final chatDetailResult =
          await ChatController().getChatDetail(roomId, next);
      next = chatDetailResult.next;
      emit(GetChatDetailSuccess(chatDetailResult: chatDetailResult));
      return chatDetailResult.result;
    } catch (e) {
      emit(GetChatDetailFailure(message: e.toString()));
    }
    return [];
  }
}
