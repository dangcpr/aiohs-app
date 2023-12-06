import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/profile/cubit/update_profile_cubit.dart';
import 'package:rmservice/utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../login/models/user.dart';
import '../widgets/text_field_custom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKeyProfile = GlobalKey<FormState>();
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = context.read<UserCubit>().state;
  }

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
    nameController.text = user.full_name;
    emailController.text = user.email;
    phoneController.text = user.phone_number;
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
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateProfileSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Success",
            desc: "Update Successfully",
            btnOkOnPress: () {},
          ).show();
        }
        if (state is UpdateProfileFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Failed",
            desc: state.message,
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
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
                      User newUser = User(
                        code: user.code,
                        full_name: nameController.text,
                        phone_number: phoneController.text,
                        email: user.email,
                      );
                      await context
                          .read<UpdateProfileCubit>()
                          .updateProfile(newUser);
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
      },
    );
  }
}
