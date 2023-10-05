import 'package:flutter/material.dart';
import 'package:rmservice/sign_up/views/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/button_green.dart';
import '../../utilities/components/text_field.dart';
import '../../utilities/constants/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.first_time});

  final bool first_time;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //check darkmode
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.height * 0.03, vertical: size.width * 0.1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.9,
                  child: Image.asset(AppAssets.login),
                ),
                Text(
                  widget.first_time
                      ? AppLocalizations.of(context)!.welCome
                      : AppLocalizations.of(context)!.welComeBack,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  AppLocalizations.of(context)!.contentWelcome,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Form(
                  key: formKeyLogin,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 85,
                        child: TextFieldApp(
                          controller: emailController,
                          label: '',
                          icon: Icons.email,
                          validatorFunc: (input) {
                            if (input!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .signupEmptyError;
                            }

                            return null;
                          },
                          darkMode: darkMode,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 95,
                        child: TextFieldApp(
                          controller: passwordController,
                          label: '',
                          icon: Icons.password,
                          obsecure: true,
                          validatorFunc: (input) {
                            if (input!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .signupEmptyError;
                            }
                            return null;
                          },
                          darkMode: darkMode,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(AppLocalizations.of(context)!.forgotPassword,
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ButtonGreenApp(
                        label: AppLocalizations.of(context)!.signIn,
                        onPressed: () {
                          if (formKeyLogin.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Text(AppLocalizations.of(context)!.orLogin,
                      style: Theme.of(context).textTheme.labelMedium),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton(assetString: AppAssets.google),
                    const SizedBox(width: 15),
                    socialButton(assetString: AppAssets.facebook),
                  ],
                ),
                const SizedBox(height: 14),
                Center(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SignupScreen(first_time: widget.first_time),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.newAccount,
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <InlineSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.signUp,
                            style: const TextStyle(
                              color: colorProject.primaryColor,
                              fontFamily: fontBoldApp,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Ink socialButton({required String assetString}) {
    return Ink(
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          assetString,
          height: 35,
          width: 35,
        ),
      ),
    );
  }
}
