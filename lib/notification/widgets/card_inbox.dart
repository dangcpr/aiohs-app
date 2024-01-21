import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/notification/controllers/inbox.dart';
import 'package:rmservice/notification/helpers/handle_time.dart';
import 'package:rmservice/notification/models/inbox.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CardInbox extends StatefulWidget {
  const CardInbox({super.key, required this.inbox});

  final Inbox inbox;

  @override
  State<CardInbox> createState() => _CardInboxState();
}

class _CardInboxState extends State<CardInbox> {
  @override
  Widget build(BuildContext context) {
    bool isOpen = widget.inbox.is_open;
    return Container(
      //padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorProject.primaryColor),
        color: isOpen == false
            ? colorProject.primaryColor.withOpacity(0.2)
            : Colors.transparent,
      ),
      child: ListTile(
        onTap: () async {
          await InboxController().readed(
              context.read<UserCubit>().state.code!, widget.inbox.id);
              
          setState(() {
            widget.inbox.is_open = true;
          });
        },
        leading: Icon(Icons.notifications, color: colorProject.primaryColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                widget.inbox.title,
                style: TextStyle(
                    fontSize: fontSize.mediumLarger,
                    fontFamily: fontBoldApp,
                    color: colorProject.primaryColor),
              ),
            
            Text(
              handleTime(context, widget.inbox.created_at),
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontApp,
                color: colorProject.subColor,
              ),
            )
          ],
        ),
        subtitle: Text(
          widget.inbox.body,
          style: TextStyle(
            fontSize: fontSize.medium,
            fontFamily: fontApp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}