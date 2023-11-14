import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_register/constants/list_work.dart';
import 'package:rmservice/worker_register/cubits/worker_cubit.dart';
import 'package:rmservice/worker_register/models/worker.dart';
import 'package:rmservice/worker_register/views/maps.dart';
import 'package:rmservice/worker_register/views/register_step2.dart';

class WorkerRegisterStep1Screen extends StatefulWidget {
  const WorkerRegisterStep1Screen({super.key});

  @override
  State<WorkerRegisterStep1Screen> createState() =>
      _WorkerRegisterStep1ScreenState();
}

class _WorkerRegisterStep1ScreenState extends State<WorkerRegisterStep1Screen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController numOfDayController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController areaController = TextEditingController();
  // TextEditingController priceController = TextEditingController();
  // TextEditingController detailController = TextEditingController();

  List<dynamic> listWork = List.empty();
  final _item =
      listJobsTest.map((job) => MultiSelectItem<Job>(job, job.name)).toList();

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    Worker worker = Worker();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trở thành người giúp việc (Bước 1/3)",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "Bạn muốn trở thành người giúp việc",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Hoàn thành các thông tin bên dưới để đăng ký, chúng tôi sẽ liên hệ bạn để trả kết quả sau 48h làm việc",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              TextLabel(
                label: "THÔNG TIN CÁ NHÂN",
                isDarkMode: darkMode,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                    controller: idController,
                    isDarkMode: darkMode,
                    hintText: "Số CMND/CCCD",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.signupEmptyError;
                      }
                      if (value.length != 9 && value.length != 12) {
                        return "CMND/CCCD không hợp lệ";
                      }
                      return null;
                    }),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: phoneController,
                  isDarkMode: darkMode,
                  hintText: "Số điện thoại",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    if (value.length != 10) {
                      return "Số điện thoại không hợp lệ";
                    }
                    return null;
                  },
                ),
              ),
              TextLabel(
                label: "Công việc bạn có thể làm",
                isDarkMode: darkMode,
              ),
              MultiSelectChipField(
                scroll: false,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                items: _item,
                initialValue: listWork,
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  return null;
                },
                onTap: (values) {
                  listWork = values;
                  print(jsonEncode(listWork.map((e) => e.toJson()).toList()));
                },
                showHeader: false,
                icon: Icon(Icons.check),
              ),
              SizedBox(height: 20),
              TextLabel(
                label: "Địa chỉ nhà bạn",
                isDarkMode: darkMode,
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ChooseLocationScreen(),
                    ),
                  );
                },
                child: Text(
                  context.watch<SaveAddressCubit>().state == null ||
                          context.watch<SaveAddressCubit>().state!.address == ""
                      ? "Chọn địa điểm"
                      : context.watch<SaveAddressCubit>().state!.address!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                    color: colorProject.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ButtonGreenApp(
          label: "Tiếp theo",
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (context.read<SaveAddressCubit>().state == null ||
                  context.read<SaveAddressCubit>().state!.address == "") {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWrong(
                        notification: "Vui lòng chọn địa chỉ nhà bạn",
                      );
                    });
                return;
              }

              worker.id = idController.text;
              worker.phone = phoneController.text;
              worker.job = listWork.cast<Job>();;
              worker.address = context.read<SaveAddressCubit>().state!.address!;
              worker.latitude =
                  context.read<SaveAddressCubit>().state!.latitude!;
              worker.longitude =
                  context.read<SaveAddressCubit>().state!.longitude!;
              
              context.read<WorkerCubit>().setWorker(worker);

              debugPrint(context.read<WorkerCubit>().state.toJson().toString());

              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: WorkerRegisterStep2Screen(),
                ),
              );
            } else
              return;
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
