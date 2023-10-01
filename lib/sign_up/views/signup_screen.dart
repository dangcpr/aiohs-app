import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field.dart';

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
  Widget build(BuildContext context) {
    //check darkmode
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Đăng ký tài khoản",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "Đăng ký tài khoản",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                "Hãy để việc nhà trở nên nhẹ nhàng!",
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
                label: "Họ và tên",
                icon: Icons.person,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return "Không được để trống";
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
                label: "Email",
                icon: Icons.email,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return "Không được để trống";
                  }
                  if (isEmailValid(input) == false) {
                    return "Không đúng định dang email";
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
                label: "Số điện thoại",
                icon: Icons.phone,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return "Không được để trống";
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
                label: "Mật khẩu",
                icon: Icons.password,
                obsecure: true,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return "Không được để trống";
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
                label: "Nhập lại mật khẩu",
                icon: Icons.password,
                obsecure: true,
                validatorFunc: (input) {
                  if (input!.isEmpty) {
                    return "Không được để trống";
                  }
                  if (input != passwordController.text) {
                    return "Vui lòng nhập lại khớp mật khẩu đã nhập";
                  } else {
                    return null;
                  }
                },
                darkMode: darkMode,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: ButtonGreenApp(
                label: "Đăng ký",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                },
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
