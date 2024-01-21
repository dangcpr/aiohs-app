import 'package:rmservice/notification/models/inbox.dart';

abstract class GetInboxState {}

class GetInboxInitial extends GetInboxState {}

class GetInboxLoading extends GetInboxState {}

class GetInboxNotLoading extends GetInboxState {}

class GetInboxSuccess extends GetInboxState {
  List<Inbox> inboxes;

  GetInboxSuccess({required this.inboxes});
}

class GetInboxError extends GetInboxState {
  String message;

  GetInboxError({required this.message});
}