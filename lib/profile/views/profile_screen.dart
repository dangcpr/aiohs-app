import 'package:flutter/material.dart';
import 'package:rmservice/home_page/home_page.dart';
import 'package:rmservice/utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKeyProfile = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingMedium),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(AppAssets.profile),
                radius: 65,
              ),
            ),
            sizedBox.largeHeight(),
            info(),
          ],
        ),
      ),
    );
  }

  Widget info() {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return Form(
      key: formKeyProfile,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 85,
            child: TextFieldApp(
              icon: Icons.person,
              controller: nameController,
              label: 'Full Name',
              darkMode: darkMode,
              validatorFunc: (input) {
                if (input == null || input.isEmpty) {
                  return 'Not empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 85,
            child: TextFieldApp(
              icon: Icons.phone,
              controller: phoneController,
              label: 'Phone',
              darkMode: darkMode,
              validatorFunc: (input) {
                if (input == null || input.isEmpty) return "Not empty";
                if (input.length != 10) return "Invalid";
                return null;
              },
            ),
          ),
          SizedBox(
            height: 85,
            child: TextFieldApp(
              enabled: false,
              icon: Icons.email,
              controller: emailController,
              label: 'Email',
              darkMode: darkMode,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: colorProject.primaryColor),
              onPressed: () async {
                if (formKeyProfile.currentState!.validate()) {
                  // User user = User(
                  //     uid: state.user.uid,
                  //     displayName: firstNameEditingController.text,
                  //     lastName: lastNameEditingController.text,
                  //     phone: phoneEditingController.text);
                  //
                  // await context.read<EditInfoCubit>().update(user);
                  //
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              },
              child: Text(
                'SAVE',
                style: TextStyle(
                  fontFamily: fontApp,
                  fontSize: 14,
                  color: Colors.white,
                  wordSpacing: 1.5,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
