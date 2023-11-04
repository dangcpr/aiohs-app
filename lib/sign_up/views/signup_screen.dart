import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/views/login_screen.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';
import 'package:rmservice/sign_up/cubits/signup_state.dart';
import 'package:rmservice/sign_up/models/user.dart';
import 'package:rmservice/sign_up/widgets/skip_button.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field.dart';
import 'package:rmservice/utilities/constants/function.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.first_time});

  final bool first_time;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with InputValidationMixin {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

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
    //check darkmode
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.keyboard_arrow_left),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.signupTitle,
          style: const TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          SkipButton(),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                AppLocalizations.of(context)!.signupTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                AppLocalizations.of(context)!.signupDesc,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            /*
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      'assets/images/camera.svg',
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF00B27D),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/no_avatar.png",
                        width: 105,
                        height: 105,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // use the email provided here
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/images/remove_avatar.svg',
                    ),
                  ),
                ],
              ),
            ),
            */
            SizedBox(
              height: 95,
              child: TextFieldApp(
                controller: nameController,
                label: AppLocalizations.of(context)!.signupName,
                icon: Icons.person,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
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
                controller: emailController,
                label: AppLocalizations.of(context)!.signupEmail,
                icon: Icons.email,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  if (isEmailValid(input) == false) {
                    return AppLocalizations.of(context)!.signupEmailError;
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
                controller: phoneController,
                label: AppLocalizations.of(context)!.signupPhone,
                icon: Icons.phone,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  if (input!.length != 10) {
                    return AppLocalizations.of(context)!.signupPhone10Chacs;
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
                label: AppLocalizations.of(context)!.signupPassword,
                icon: Icons.password,
                obsecure: true,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  if (isPasswordValid(input) == false) {
                    return AppLocalizations.of(context)!
                        .signupPasswordLengthError;
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
                controller: confirmController,
                label: AppLocalizations.of(context)!.signupConfirm,
                icon: Icons.password,
                obsecure: true,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  if (input != passwordController.text) {
                    return AppLocalizations.of(context)!.signupConfirmError;
                  } else {
                    return null;
                  }
                },
                darkMode: darkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  if (state is SignupLoadingState) {
                    return TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey,
                        ),
                      ),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    if (state is SignupCompleteState) {
                      successMessage(
                          AppLocalizations.of(context)!.signupSuccess, context);
                      //Làm trò gì tiếp theo phía dưới
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeftWithFade,
                      //     child: SignupScreen(first_time: false),
                      //     childCurrent: LoginScreen(first_time: false),
                      //   ),
                      //   (route) => false,
                      // );
                    }
                    if (state is SignupErrorState) {
                      errorMessage(state.error, context);
                    }
                    return ButtonGreenApp(
                      label: AppLocalizations.of(context)!.signupButton,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<SignupCubit>(context).signup(
                            UserSignup(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            ),
                          );
                        } else {
                          return;
                        }
                      },
                    );
                  }
                },
              ),
            ),
            /*
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ButtonGreenApp(
                label: AppLocalizations.of(context)!.signupButton,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    SignupController().signup(
                      UserSignup(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        password: passwordController.text,
                      ),
                    );
                  } else {}
                },
              ),
            ),
            */
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
