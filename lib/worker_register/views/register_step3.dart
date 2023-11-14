import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/indicator/custom_progress_indicator.dart';
import 'package:rmservice/utilities/widget/success.dart';
import 'package:rmservice/worker_register/cubits/worker_cubit.dart';
import 'package:rmservice/worker_register/cubits/worker_register/worker_register_cubit.dart';
import 'package:rmservice/worker_register/cubits/worker_register/worker_register_state.dart';
import 'package:rmservice/worker_register/widgets/worker_info.dart';

class WorkerRegisterStep3Screen extends StatefulWidget {
  const WorkerRegisterStep3Screen({super.key});

  @override
  State<WorkerRegisterStep3Screen> createState() =>
      _WorkerRegisterStep3ScreenState();
}

class _WorkerRegisterStep3ScreenState extends State<WorkerRegisterStep3Screen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<WorkerRegisterCubit, WorkerRegisterState>(
      listener: (context, state) {
        if (state is WorkerRegisterSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 400),
              type: PageTransitionType.rightToLeftWithFade,
              child: SuccessScreen(),
            ),
          );
          BlocProvider.of<WorkerRegisterCubit>(context).setInit();
        }

        if (state is WorkerRegisterErrorState) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return DialogWrong(
                notification: state.error,
              );
            },
          );
        }

        if (state is WorkerRegisterLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorProject.primaryColor,
                    ),
                  ),
                ),
              );
            },
          );
          BlocProvider.of<WorkerRegisterCubit>(context).setInit();
        } else {
          return;
        }
      },
      bloc: BlocProvider.of<WorkerRegisterCubit>(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Trở thành người giúp việc (Bước 3/3)",
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: <Widget>[
              TextLabel(
                label: "VUI LÒNG XÁC NHẬN THÔNG TIN",
                isDarkMode: isDarkMode,
                color: colorProject.primaryColor,
              ),
              SizedBox(height: 20),
              TextLabel(
                label: "Thông tin cá nhân",
                isDarkMode: isDarkMode,
              ),
              WorkerInfo(isDarkMode: isDarkMode),
              SizedBox(height: 10),
              TextLabel(
                label: "CMND/CCCD mặt trước",
                isDarkMode: isDarkMode,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Image.file(context.read<WorkerCubit>().state.idF!),
              ),
              SizedBox(height: 20),
              TextLabel(
                label: "CMND/CCCD mặt sau",
                isDarkMode: isDarkMode,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Image.file(context.read<WorkerCubit>().state.idB!),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ButtonGreenApp(
            label: "Gửi thông tin",
            onPressed: () {
              BlocProvider.of<WorkerRegisterCubit>(context).register();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
