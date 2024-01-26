import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/cubits/get_chat_detail/get_chat_detail_state.dart';
import 'package:rmservice/chat/models/chat_detail.dart';

class GetChatDetailCubit extends Cubit<GetChatDetailState> {
  GetChatDetailCubit() : super(GetChatDetailInitial());
  String next = "0";
  List<ChatDetail> listChatDetail = [];

  Future<void> getChatDetail(String chatId) async {
    emit(GetChatDetailLoading());
    try {
      final chatDetail = await ChatController().getChatDetail(chatId, next);
      listChatDetail.addAll(chatDetail.result);
      next = chatDetail.next;
      emit(GetChatDetailSuccess(listChatDetail: listChatDetail));
    } catch (e) {
      emit(GetChatDetailFailure(message: e.toString()));
    }
  }
}