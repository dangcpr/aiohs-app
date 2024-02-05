// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/forgot_password/controllers/forgot_pass.dart';
import 'package:rmservice/login/views/login_page.dart';
import 'package:rmservice/profile/widgets/text_field_custom.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordSet extends StatefulWidget {
  const ForgotPasswordSet({super.key, required this.userCode});

  final String userCode;

  @override
  State<ForgotPasswordSet> createState() => _ForgotPasswordSetState();
}

class _ForgotPasswordSetState extends State<ForgotPasswordSet> {
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController reNewPassController = TextEditingController();
  final formKeyForgotPasswordSet = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Quên mật khẩu',
          style: textStyle.headerStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(padding.paddingLarge),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quên mật khẩu',
                style: textStyle.headerStyle(fontSize: fontSize.mediumLarger),
              ),
              SizedBox(height: 10),
              Text(
                'Vui lòng nhập các thông tin bên dưới để đổi mật khẩu',
                style: textStyle.normalStyle(fontSize: fontSize.medium),
              ),
              SizedBox(height: 20),
              Form(
                key: formKeyForgotPasswordSet,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: TextFieldApp(
                        controller: otpController,
                        obsecure: true,
                        label: 'Mã OTP (được gửi trong email)',
                        icon: Icons.email,
                        validatorFunc: (input) {
                          if (input!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .signupEmptyError;
                          } else {
                            return null;
                          }
                        },
                        darkMode: isDarkMode,
                      ),
                    ),
                    //SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: TextFieldApp(
                        controller: newPassController,
                        obsecure: true,
                        label: 'Mật khẩu mới',
                        icon: Icons.password,
                        validatorFunc: (input) {
                          if (input!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .signupEmptyError;
                          } else {
                            return null;
                          }
                        },
                        darkMode: isDarkMode,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: TextFieldApp(
                        controller: reNewPassController,
                        obsecure: true,
                        label: 'Nhập lại mật khẩu mới',
                        icon: Icons.password,
                        validatorFunc: (input) {
                          if (input!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .signupEmptyError;
                          }

                          if (input != newPassController.text) {
                            return 'Mật khẩu mới không khớp';
                          } else {
                            return null;
                          }
                        },
                        darkMode: isDarkMode,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ButtonGreenApp(
                        label: 'Đặt lại mật khẩu',
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: colorProject.primaryColor),
                              );
                            },
                          );

                          if (formKeyForgotPasswordSet.currentState!
                              .validate()) {
                            try {
                              await ForgotPassController().forgotPassSet(
                                userCode: widget.userCode,
                                otp: otpController.text,
                                password: newPassController.text,
                              );
                              AwesomeDialog(
                                context: context,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.success,
                                animType: AnimType.bottomSlide,
                                title: 'Đổi mật khẩu thành công',
                                desc:
                                    'Đổi mật khẩu thành công. Vui lòng đăng nhập ứng dụng.',
                                btnOkOnPress: () {
                                  //Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      duration: Duration(milliseconds: 400),
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: LoginPage(first_time: false),
                                    ),
                                  );
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
                                btnCancelOnPress: () {},
                              ).show();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
