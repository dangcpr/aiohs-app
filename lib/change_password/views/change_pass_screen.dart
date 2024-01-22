// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/change_password/controllers/change_pass.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/profile/widgets/text_field_custom.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    TextEditingController oldPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    TextEditingController reNewPassController = TextEditingController();
    String userCode = context.read<UserCubit>().state.code!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldApp(
                  icon: Icons.password,
                  controller: oldPassController,
                  darkMode: isDarkMode,
                  label: 'Mật khẩu cũ',
                  obsecure: true,
                  validatorFunc: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu cũ';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldApp(
                  icon: Icons.password,
                  controller: newPassController,
                  darkMode: isDarkMode,
                  label: 'Mật khẩu mới',
                  obsecure: true,
                  validatorFunc: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu mới';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldApp(
                  icon: Icons.password,
                  controller: reNewPassController,
                  darkMode: isDarkMode,
                  label: 'Nhập lại mật khẩu mới',
                  obsecure: true,
                  validatorFunc: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập lại mật khẩu mới';
                    }
                    if (value != newPassController.text) {
                      return 'Nhập lại mật khẩu không khớp với mật khẩu mới';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ButtonGreenApp(
                  label: "Đổi mật khẩu",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        title: 'Xác nhận đổi mật khẩu',
                        titleTextStyle: const TextStyle(
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.large,
                          color: Color.fromARGB(255, 245, 127, 23),
                        ),
                        desc: 'Bạn có chắc chắn muốn đổi mật khẩu?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          showDialog(
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                  color: colorProject.primaryColor),
                            ),
                          );
                          try {
                            await ChangePassController().changePass(
                              userCode: userCode,
                              oldPass: oldPassController.text,
                              newPass: newPassController.text,
                            );
                            Navigator.pop(context);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              title: 'Đổi mật khẩu thành công',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          } catch (e) {
                            Navigator.pop(context);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: 'Đổi mật khẩu thất bại',
                              titleTextStyle: const TextStyle(
                                fontFamily: fontBoldApp,
                                fontSize: fontSize.large,
                                color: Colors.red,
                              ),
                              desc: e.toString(),
                              btnCancelOnPress: () {
                                //12Navigator.pop(context);
                              },
                            ).show();
                          }
                        },
                      ).show();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
