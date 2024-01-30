import 'package:rmservice/chat/models/chat_detail.dart';

abstract class GetChatDetailState {}

class GetChatDetailInitial extends GetChatDetailState {}

class GetChatDetailLoading extends GetChatDetailState {}

class GetChatDetailSuccess extends GetChatDetailState {
  final ChatDetailResult chatDetailResult;

  GetChatDetailSuccess({required this.chatDetailResult});
}

class GetChatDetailFailure extends GetChatDetailState {
  final String message;

  GetChatDetailFailure({required this.message});
}
