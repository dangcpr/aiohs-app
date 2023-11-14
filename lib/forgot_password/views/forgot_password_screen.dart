import 'package:flutter/material.dart';
import 'package:rmservice/login/views/login_page.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/button_green.dart';
import '../../utilities/components/text_field.dart';
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
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(padding.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quên mật khẩu',
            style: textStyle.headerStyle(fontSize: 18),
          ),
          sizedBox.mediumHeight(),
          Text(
            'Vui lòng nhập email để xác nhận lại mật khẩu',
            style: textStyle.normalStyle(),
          ),
          sizedBox.mediumHeight(),
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
                sizedBox.mediumHeight(),
                ButtonGreenApp(
                  label: 'Quên mật khẩu',
                  onPressed: () {
                    if (formKeyForgotPassword.currentState!.validate()) {
                      //   context.read<LoginCubit>().logIn(
                      //         username: emailController.text,
                      //         password: passwordController.text,
                      //       );
                      // }
                      // else {
                      //   return;
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(first_time: false),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
