import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_register/controllers/bank_vn.dart';
import 'package:rmservice/worker_register/controllers/worker_register.dart';
import 'package:rmservice/worker_register/models/bank_vn.dart';
import 'package:rmservice/worker_register/views/maps.dart';

class WorkerRegisterStep2Screen extends StatefulWidget {
  const WorkerRegisterStep2Screen(
      {super.key,
      this.full_name,
      this.identiny_no,
      this.issue_on,
      this.permanent_address,
      this.date_of_birth,
      this.place_of_birth,
      required this.identity_front_image_url,
      required this.identity_back_image_url});

  final String? full_name;
  final String? identiny_no;
  final String? issue_on;
  final String? permanent_address;
  final String? date_of_birth;
  final String? place_of_birth;
  final File identity_front_image_url;
  final File identity_back_image_url;

  @override
  State<WorkerRegisterStep2Screen> createState() =>
      _WorkerRegisterStep1ScreenState();
}

class _WorkerRegisterStep1ScreenState extends State<WorkerRegisterStep2Screen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController issueOnController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  String bankCode = "";
  String bankName = "";
  TextEditingController bankHolderController = TextEditingController();
  TextEditingController bankNoController = TextEditingController();

  List<dynamic> listWork = List.empty();
  // final _item =
  //     listJobsTest.map((job) => MultiSelectItem<Job>(job, job.name)).toList();

  @override
  void initState() {
    super.initState();
    idController.text = widget.identiny_no ?? "";
    nameController.text = widget.full_name == null
        ? (context.read<UserCubit>().state.full_name == ""
            ? ""
            : context.read<UserCubit>().state.full_name)
        : widget.full_name!;
    dateOfBirthController.text = widget.date_of_birth ?? "";
    String permanentAddress = widget.permanent_address == null
        ? ""
        : widget.permanent_address!.replaceAll("\n", ", ");
    permanentAddressController.text = permanentAddress;
    issueOnController.text = widget.issue_on ?? "";
    String placeOfBirth = widget.place_of_birth == null
        ? ""
        : widget.place_of_birth!.replaceAll("\n", ", ");

    placeOfBirthController.text = placeOfBirth;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    //Worker worker = Worker();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trở thành người giúp việc (Bước 2/2)",
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
              // Padding(
              //   padding: EdgeInsets.zero,
              //   child: Text(
              //     "Bạn muốn trở thành người giúp việc",
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: Text(
              //     "Hoàn thành các thông tin bên dưới để đăng ký, chúng tôi sẽ liên hệ bạn để trả kết quả sau 48h làm việc",
              //     style: Theme.of(context).textTheme.labelMedium,
              //   ),
              // ),
              TextLabel(
                label: "THÔNG TIN CÁ NHÂN",
                isDarkMode: darkMode,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: nameController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.full_name != null ? true : false,
                  hintText: "Họ và tên bạn",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: idController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.identiny_no != null ? true : false,
                  hintText: "Số CMND/CCCD",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    if (value.length != 9 && value.length != 12) {
                      return "CMND/CCCD không hợp lệ";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: issueOnController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.issue_on != null ? true : false,
                  hintText: "Ngày cấp CCCD (dd/mm/yyyy)",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    final RegExp sampleRegex = RegExp(
                        r'(([012][0-9])|(3[01]))\/([0]{0,1}[1-9]|1[012])\/\d{4}');
                    if (!sampleRegex.hasMatch(value)) {
                      return "Ngày cấp CCCD không hợp lệ. Định dạng dd/mm/yyyy";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: dateOfBirthController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.date_of_birth != null ? true : false,
                  hintText: "Ngày sinh (dd/mm/yyyy)",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    final RegExp sampleRegex = RegExp(
                        r'(([012][0-9])|(3[01]))\/([0]{0,1}[1-9]|1[012])\/\d{4}');
                    if (!sampleRegex.hasMatch(value)) {
                      return "Ngày cấp CCCD không hợp lệ. Định dạng dd/mm/yyyy";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: placeOfBirthController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.place_of_birth != null ? true : false,
                  hintText: "Nơi sinh",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: permanentAddressController,
                  isDarkMode: darkMode,
                  isReadOnly: widget.permanent_address != null ? true : false,
                  hintText: "Địa chỉ thường trú",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    return null;
                  },
                ),
              ),
              TextLabel(
                label: "Ngân hàng",
                isDarkMode: darkMode,
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 85,
                child: FutureBuilder(
                  future: BankVNController().getBankVN(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .signupEmptyError;
                          }
                          return null;
                        },
                        hint: Text("Chọn ngân hàng"),
                        items: (snapshot.data as List<BankVN>)
                            .map((e) => DropdownMenuItem(
                                child: Text(e.shortName), value: e.shortName))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            bankCode = value!.toString();
                            debugPrint(bankCode);
                            bankName = (snapshot.data as List<BankVN>)
                                .firstWhere(
                                    (element) => element.shortName == bankCode)
                                .name;
                            debugPrint(bankName);
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorProject.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                    return Text("Đang chờ ...");
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: bankHolderController,
                  isDarkMode: darkMode,
                  hintText: "Tên chủ tài khoản",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: bankNoController,
                  isDarkMode: darkMode,
                  hintText: "Số tài khoản",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    return null;
                  },
                ),
              ),

              TextLabel(
                label: "Địa chỉ liên lạc",
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

              AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.bottomSlide,
                showCloseIcon: true,
                title: 'Bạn có chắc chắn đăng ký?',
                desc: 'Lưu ý rằng thao tác này sẽ không thể hoàn tác',
                btnOkOnPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: colorProject.primaryColor),
                      );
                    },
                  );
                  try {
                    int result = await WorkerRegisterController().register(
                        context.read<UserCubit>().state.code!,
                        nameController.text,
                        idController.text,
                        issueOnController.text,
                        permanentAddressController.text,
                        dateOfBirthController.text,
                        placeOfBirthController.text,
                        widget.identity_front_image_url,
                        widget.identity_back_image_url,
                        context.read<SaveAddressCubit>().state!.address!,
                        bankCode,
                        bankName,
                        bankHolderController.text,
                        bankNoController.text);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.bottomSlide,
                      showCloseIcon: true,
                      title: result == 1
                          ? 'Đăng ký thành công'
                          : 'Cập nhật thông tin thành công',
                      btnCancelOnPress: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ).show();
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);

                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      showCloseIcon: true,
                      title: 'Có lỗi xảy ra',
                      titleTextStyle: TextStyle(
                        color: Colors.red,
                        fontFamily: fontBoldApp,
                        fontSize: fontSize.large,
                      ),
                      desc: e.toString(),
                    ).show();
                  }
                },
              ).show();
            } else
              return;
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
