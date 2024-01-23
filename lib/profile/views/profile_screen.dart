import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/home_page/home_page.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/profile/cubit/update_avatar/update_avatar_cubit.dart';
import 'package:rmservice/profile/cubit/update_profile/update_profile_cubit.dart';
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

  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    user.full_name != ""
        ? nameController.text = user.full_name
        : nameController.text = 'User Name';
    emailController.text = user.email;
    user.phone_number != ""
        ? phoneController.text = user.phone_number
        : phoneController.text = "0123456789";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingMedium),
        child: Column(
          children: [
            BlocConsumer<UpdateAvatarCubit, UpdateAvatarState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is UpdateAvatarLoading) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: colorProject.primaryColor,
                          ),
                        );
                      });
                }
                if (state is UpdateAvatarSuccess) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    title: "Success",
                    desc: "Update Successfully",
                    btnOkOnPress: () {
                      context.read<UserCubit>().state.avatar_url =
                          state.user.avatar_url;
                      result = null;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                return Center(
                    child: Stack(
                  children: [
                    result != null
                        ? CircleAvatar(
                            backgroundImage:
                                FileImage(File(result!.paths.first!)),
                            radius: 65,
                          )
                        : context.read<UserCubit>().state.avatar_url!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${context.read<UserCubit>().state.avatar_url}'),
                                radius: 65,
                              )
                            : CircleAvatar(
                                backgroundImage: AssetImage(AppAssets.profile),
                                radius: 65,
                              ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: colorProject.primaryColor,
                        radius: 20,
                        child: IconButton(
                          onPressed: () async {
                            result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowMultiple: false,
                              allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
                            );
                            if (result != null) {
                              setState(() {
                                File file = File(result!.paths.first!);
                                context
                                    .read<UpdateAvatarCubit>()
                                    .updateAvatar(user.code!, file);
                              });
                            } else {
                              return;
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ));
              },
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
    var userCubit = context.read<UserCubit>().state;
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
            btnOkOnPress: () {
              userCubit.full_name = state.user.full_name;
              userCubit.phone_number = state.user.phone_number;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
          ).show();
        }
        if (state is UpdateProfileFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            titleTextStyle: TextStyle(color: Colors.red),
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Failed",
            desc: 'Thông tin không hợp lệ \n Tên và SĐT không thay đổi',
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
                      var userCode = userCubit.code;
                      var fullName = nameController.text;
                      var phone = phoneController.text;
                      var email = userCubit.email;
                      await context
                          .read<UpdateProfileCubit>()
                          .updateProfile(userCode!, fullName, phone, email!);
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
