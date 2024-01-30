part of 'get_list_chat_cubit.dart';

@immutable
abstract class GetListChatState {}

class GetListChatInitial extends GetListChatState {}

class GetListChatLoading extends GetListChatState {}

class GetListChatLoaded extends GetListChatState {
  final List<ChatInfo> listChatInfo;
  GetListChatLoaded({required this.listChatInfo});
}

class GetListChatFailed extends GetListChatState {
  final String error;
  GetListChatFailed({required this.error});
}
