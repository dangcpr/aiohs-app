// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/notification/controllers/inbox.dart';
import 'package:rmservice/notification/cubits/get_inbox/get_inbox_cubit.dart';
import 'package:rmservice/notification/cubits/get_inbox/get_inbox_state.dart';
import 'package:rmservice/notification/cubits/unread_cubit.dart';
import 'package:rmservice/notification/widgets/card_inbox.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetInboxCubit>()
        .getInbox(context.read<UserCubit>().state.code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo',
            style: TextStyle(fontSize: fontSize.mediumLarger)),
        actions: [
          IconButton(
            tooltip: "Đánh dấu tất cả đã đọc",
            onPressed: () async {
              await InboxController().readedAll(
                  context.read<UserCubit>().state.code!);
              await context
                  .read<GetInboxCubit>()
                  .getInboxNoLoad(context.read<UserCubit>().state.code!);
              context.read<UnreadNotiCubit>().setReadNotiAll();
            },
            icon: const Icon(Icons.mark_email_read, color: colorProject.primaryColor),
          ),
          IconButton(
            tooltip: "Xóa toàn bộ thông báo",
            onPressed: () async {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide,
                title: 'Xóa toàn bộ thông báo',
                titleTextStyle: TextStyle(
                    fontSize: fontSize.large,
                    fontFamily: fontBoldApp,
                    color: Colors.yellow.shade900),
                desc: 'Bạn có chắc chắn muốn xóa toàn bộ thông báo?',
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  await InboxController().deleteAll(
                      context.read<UserCubit>().state.code!);
                  await context
                      .read<GetInboxCubit>()
                      .getInbox(context.read<UserCubit>().state.code!);
                  context.read<UnreadNotiCubit>().setReadNotiAll();
                },
              ).show();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
            onPressed: () async {
              await context
                  .read<GetInboxCubit>()
                  .getInbox(context.read<UserCubit>().state.code!);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: RefreshIndicator(
        color: colorProject.primaryColor,
        onRefresh: () async {
          context
              .read<GetInboxCubit>()
              .getInbox(context.read<UserCubit>().state.code!);
        },
        child: BlocBuilder<GetInboxCubit, GetInboxState>(
          bloc: context.read<GetInboxCubit>(),
          builder: (context, state) {
            if (state is GetInboxLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(color: colorProject.primaryColor),
              );
            }

            if (state is GetInboxError) {
              return WorkerEmptyOrder(
                title: "Có lỗi xảy ra",
                desc: state.message,
              );
            }

            if (state is GetInboxSuccess ||
                state is GetInboxInitial ||
                state is GetInboxNotLoading) {
              if (context.read<GetInboxCubit>().inboxes_C.isEmpty) {
                return const WorkerEmptyOrder(
                  title: "Không có thông báo",
                  desc:
                      "Hiện tại bạn không có thông báo nào. Vui lòng quay lại sau!",
                );
              } else {
                return ListView.builder(
                  itemCount: context.read<GetInboxCubit>().inboxes_C.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: CardInbox(
                        inbox: context.read<GetInboxCubit>().inboxes_C[index],
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: SizedBox(),
              );
            }
          },
        ),
      ),
    );
  }
}
