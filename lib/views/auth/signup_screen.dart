import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmservice/components/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.first_time});

  final bool first_time;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Key formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: Text("Đăng ký tài khoản",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Text("Hãy để việc nhà trở nên nhẹ nhàng!",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
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
                    onPressed: null,
                    icon: SvgPicture.asset(
                      'assets/images/remove_avatar.svg',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFieldApp(
                controller: nameController,
                label: "Họ và tên",
                icon: Icons.person,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFieldApp(
                controller: emailController,
                label: "Email",
                icon: Icons.email
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFieldApp(
                controller: passwordController,
                label: "Mật khẩu",
                icon: Icons.password,
                obsecure: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFieldApp(
                controller: confirmController,
                label: "Nhập lại mật khẩu",
                icon: Icons.password,
                obsecure: true,
              ),
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
