// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/forgot_password/controllers/forgot_pass.dart';
import 'package:rmservice/forgot_password/views/forgot_password_set.dart';
import 'package:rmservice/forgot_password/widgets/circle_indicator_button.dart';
import 'package:rmservice/profile/widgets/text_field_custom.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final formKeyForgotPassword = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
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
              'Vui lòng nhập email để lấy OTP đổi mật khẩu (OTP chỉ có hiệu lực trong 15 phút)',
              style: textStyle.normalStyle(fontSize: fontSize.medium),
            ),
            SizedBox(height: 20),
            Form(
              key: formKeyForgotPassword,
              child: Column(
                children: [
                  SizedBox(
                    height: 85,
                    child: TextFieldApp(
                      controller: emailController,
                      label: 'Email',
                      icon: Icons.email,
                      validatorFunc: (input) {
                        if (input!.isEmpty) {
                          return AppLocalizations.of(context)!.signupEmptyError;
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(input)) {
                          return 'Invalid format';
                        } else {
                          return null;
                        }
                      },
                      darkMode: darkMode,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: loading == false
                        ? ButtonGreenApp(
                            label: 'Gửi mã OTP',
                            onPressed: () async {
                              if (formKeyForgotPassword.currentState!
                                  .validate()) {
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  debugPrint(emailController.text);
                                  String userCode = await ForgotPassController()
                                      .forgotPassOTP(emailController.text);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      duration: Duration(milliseconds: 400),
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: ForgotPasswordSet(
                                        userCode: userCode,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.bottomSlide,
                                    title: 'Gửi mã OTP thất bại',
                                    titleTextStyle: const TextStyle(
                                      fontFamily: fontBoldApp,
                                      fontSize: fontSize.large,
                                      color: Colors.red,
                                    ),
                                    desc: e.toString(),
                                    btnCancelOnPress: () {},
                                  ).show();
                                }
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                          )
                        : CircleIndicatorButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
