import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/notification/controllers/inbox.dart';
import 'package:rmservice/notification/cubits/get_inbox/get_inbox_state.dart';
import 'package:rmservice/notification/models/inbox.dart';

class GetInboxCubit extends Cubit<GetInboxState> {
  GetInboxCubit() : super(GetInboxInitial());

  List<Inbox> inboxes_C = [];

  Future<void> getInbox(String userCode) async {
    emit(GetInboxLoading());
    try {
      List<Inbox> inboxes = await InboxController().getInbox(userCode);
      inboxes_C = inboxes;
      emit(GetInboxSuccess(inboxes: inboxes));
    } catch (e) {
      emit(GetInboxError(message: e.toString()));
    }
  }

  Future<void> getInboxNoLoad(String userCode) async {
    emit(GetInboxNotLoading());
    try {
      List<Inbox> inboxes = await InboxController().getInbox(userCode);
      inboxes_C = inboxes;
      emit(GetInboxSuccess(inboxes: inboxes));
    } catch (e) {
      emit(GetInboxError(message: e.toString()));
    }
  }
}