import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/home_page/home_page.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/sign_up/views/signup_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../forgot_password/forgot_password.dart';
import '../../utilities/components/button_green.dart';
import '../../utilities/components/text_field.dart';
import '../../utilities/constants/app_assets.dart';
import '../../utilities/dialog/dialog.dart';
import '../../utilities/indicator/custom_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.first_time});

  final bool first_time;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  final formKeyLogin = GlobalKey<FormState>();
  // TextEditingController emailController =
  //     TextEditingController(text: 'namvay1@gmail.com');
  // TextEditingController passwordController =
  //     TextEditingController(text: '123456');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool oauth = false;
  @override
  void initState() {
    super.initState();
  }

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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (_) {
              final width = MediaQuery.of(context).size.width / 5 + 10;
              return CustomProgressIndicator(
                limitedRadius: width,
              );
            },
          );
        } else if (state is LoginFailure) {
          Navigator.pop(context);
          showCustomDialog(
            context: context,
            dialogType: CustomDialogType.FAILURE,
            msg: state.error.toString(),
            isMultipleButton: false,
          );
        } else if (state is LoginSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          );
          context.read<UserCubit>().setUser(state.user);
          context.read<LoginCubit>().setInit();
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pop(context);
            return HomePage();
          }
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
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            SizedBox(
                              height: 85,
                              child: TextFieldApp(
                                controller: emailController,
                                label: 'Email',
                                icon: Icons.email,
                                validatorFunc: (input) {
                                  if (input!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .signupEmptyError;
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
                            SizedBox(
                              height: 95,
                              child: TextFieldApp(
                                controller: passwordController,
                                label: AppLocalizations.of(context)!.password,
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
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      PageTransition(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: ForgotPasswordPage(),),),
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .forgotPassword,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ButtonGreenApp(
                              label: AppLocalizations.of(context)!.signIn,
                              onPressed: () {
                                if (formKeyLogin.currentState!.validate()) {
                                  context.read<LoginCubit>().logIn(
                                        username: emailController.text,
                                        password: passwordController.text,
                                      );
                                } else {
                                  return;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      if ((hasOauth_G == true || hasOauth_F == true) || !Platform.isIOS)
                        Center(
                          child: Text(AppLocalizations.of(context)!.orLogin,
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      if ((hasOauth_G == true || hasOauth_F == true) || !Platform.isIOS) const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (hasOauth_G == true || !Platform.isIOS)
                              socialButton(
                                assetString: AppAssets.google,
                                onTap: () async {
                                  context.read<LoginCubit>().logInGoogle();
                                },
                              ),
                            if (hasOauth_F == true || !Platform.isIOS) const SizedBox(width: 15),
                            if (hasOauth_F == true || !Platform.isIOS)
                              socialButton(
                                assetString: AppAssets.facebook,
                                onTap: () async {
                                  context.read<LoginCubit>().logInFB();
                                },
                              ),
                          ],
                        ),
                      if ((hasOauth_G == true || hasOauth_F == true) || !Platform.isIOS) const SizedBox(height: 14),
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
        },
      ),
    );
  }

  Ink socialButton(
      {required String assetString, required VoidCallback? onTap}) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          assetString,
          height: 35,
          width: 35,
        ),
      ),
    );
  }
}
