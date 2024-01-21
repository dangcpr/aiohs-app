import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/notification/cubits/get_inbox/get_inbox_cubit.dart';
import 'package:rmservice/notification/views/noti_screen.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInboxCubit(),
      child: NotiScreen(),
    );
  }
}
