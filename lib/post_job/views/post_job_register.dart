import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/login/models/user.dart';
import 'package:rmservice/post_job/constants/sex_choose.dart';
import 'package:rmservice/post_job/cubits/images_place_cubit.dart';
import 'package:rmservice/post_job/cubits/post_job_cubit/post_job_cubit.dart';
import 'package:rmservice/post_job/cubits/save_info_job_posting.dart';
import 'package:rmservice/post_job/views/post_job_confirm.dart';
import 'package:rmservice/post_job/views/post_job_screen.dart';
import 'package:rmservice/post_job/widgets/image_list_and_button.dart';
import 'package:rmservice/post_job/constants/salary_method.dart';
import 'package:rmservice/post_job/views/maps.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../shopping/widgets/dialog_wrong.dart';
import '../../utilities/components/text_label.dart';
import '../models/post_job_info.dart';

class PostJobRegister extends StatefulWidget {
  const PostJobRegister({super.key});

  @override
  State<PostJobRegister> createState() => _PostJobRegisterState();
}

class _PostJobRegisterState extends State<PostJobRegister> {
  final formKey = GlobalKey<FormState>();

  // API thieu
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //

  TextEditingController titleController = TextEditingController();
  TextEditingController numberEmployeeController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController wageTypeController = TextEditingController();
  TextEditingController wageTypeDisplayController = TextEditingController();
  TextEditingController wageMinController = TextEditingController();
  TextEditingController wageMaxController = TextEditingController();
  TextEditingController candidateGenderController =
      TextEditingController(text: 'male');
  TextEditingController candidateMinAgeController = TextEditingController();
  TextEditingController candidateMaxAgeController = TextEditingController();
  TextEditingController candidateExpController = TextEditingController();

  String selectedValue = "h";
  int indexSex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    numberEmployeeController.dispose();
    desController.dispose();
    wageTypeController.dispose();
    wageMinController.dispose();
    wageMaxController.dispose();
    candidateGenderController.dispose();
    candidateMinAgeController.dispose();
    candidateMaxAgeController.dispose();
    candidateExpController.dispose();
    wageTypeDisplayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<PostJobCubit, PostJobState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is PostJobLoading) {
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
        if (state is PostJobSuccess) {
          // Navigator.push(
          //     context,
          //     PageTransition(
          //       duration: Duration(milliseconds: 400),
          //       type: PageTransitionType.rightToLeftWithFade,
          //       child: PostJobConfirm(),
          //     ));
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Success",
            desc: 'Post job successfully',
            btnOkOnPress: () {
              context.read<SaveInfoJobPostingCubit>().setInitial();
              context.read<ImagesPlaceCubitForJobPosting>().state.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PostJobScreen(),
                ),
              );
            },
          ).show();
        }
        if (state is PostJobFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Failed",
            desc: state.message,
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Đăng tin giúp việc (Bước 1/2)",
            style: TextStyle(
              fontSize: fontSize.mediumLarger,
              fontFamily: fontBoldApp,
            ),
          ),
          leading: InkWell(
            onTap: () {
              context.read<SaveInfoJobPostingCubit>().setInitial();
              context.read<ImagesPlaceCubitForJobPosting>().setInit();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PostJobScreen(),
                ),
              );
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
            child: ListView(
              padding: EdgeInsets.only(top: 20),
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "Đăng tin tuyển giúp việc",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Nếu bạn cần giúp việc linh hoạt hơn hãy vui lòng điền thông tin bên dưới",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                // TextLabel(
                //   label: "THÔNG TIN CÁ NHÂN",
                //   isDarkMode: darkMode,
                // ),
                // SizedBox(height: 20),
                // SizedBox(
                //   height: 85,
                //   child: TextFieldBasic(
                //     controller: nameController,
                //     isDarkMode: darkMode,
                //     hintText: "Họ và tên người đại diện",
                //     validator: (input) {
                //       if (input!.isEmpty) {
                //         return 'Vui lòng không để trống';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 85,
                //   child: TextFieldBasic(
                //     controller: phoneController,
                //     isDarkMode: darkMode,
                //     hintText: "Số điện thoại",
                //     validator: (input) {
                //       if (input!.isEmpty) {
                //         return 'Vui lòng không để trống';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Địa chỉ làm việc",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.rightToLeftWithFade,
                        child: ChooseLocationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    context.watch<SaveAddressCubit>().state == null ||
                            context.watch<SaveAddressCubit>().state!.address ==
                                ""
                        ? "Chọn địa điểm"
                        : context.watch<SaveAddressCubit>().state!.address!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                      color: colorProject.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextLabel(
                  label: "NỘI DUNG ĐĂNG TUYỂN",
                  isDarkMode: darkMode,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: titleController,
                    isDarkMode: darkMode,
                    hintText: "Tiêu đề tin",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: numberEmployeeController,
                    isDarkMode: darkMode,
                    hintText: "Số lượng tuyển dụng",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                TextFieldLong(
                  height: 125,
                  controller: desController,
                  isDarkMode: darkMode,
                  hintText: "Chi tiết về công việc",
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Vui lòng không để trống';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Hình thức trả lương",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  value: selectedValue,
                  items: dropdownSalaryMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                    wageTypeController.text = selectedValue;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: wageMinController,
                    isDarkMode: darkMode,
                    hintText: "Lương tối thiểu (VNĐ)",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: wageMaxController,
                    isDarkMode: darkMode,
                    hintText: "Lương tối đa (VNĐ)",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Hình ảnh nơi làm việc",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ImageListAndButton(),
                SizedBox(height: 20),
                TextLabel(
                  label: "YÊU CẦU ỨNG VIÊN",
                  isDarkMode: darkMode,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Giới tính",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    3,
                    (int index) {
                      return ChoiceChip(
                        selectedColor:
                            colorProject.primaryColor.withOpacity(0.4),
                        label: Text(
                          sexList[index],
                          style: TextStyle(fontFamily: fontBoldApp),
                        ),
                        selected: indexSex == index,
                        onSelected: (bool selected) {
                          setState(() {
                            indexSex = selected ? index : -1;
                          });
                          candidateGenderController.text = sexList[index];
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: candidateMinAgeController,
                    isDarkMode: darkMode,
                    hintText: "Độ tuổi tối thiểu",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: TextFieldBasic(
                    controller: candidateMaxAgeController,
                    isDarkMode: darkMode,
                    hintText: "Độ tuổi tối đa",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Vui lòng không để trống';
                      }
                      return null;
                    },
                  ),
                ),
                TextFieldLong(
                  height: 125,
                  controller: candidateExpController,
                  isDarkMode: darkMode,
                  hintText: "Yêu cầu kinh nghiệm",
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Vui lòng không để trống';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ButtonGreenApp(
              label: "Tiếp theo",
              onPressed: () {
                final cubit = context.read<SaveInfoJobPostingCubit>().state;
                if (formKey.currentState!.validate()) {
                  if (context.read<SaveAddressCubit>().state == null ||
                      context.read<SaveAddressCubit>().state!.address == "") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWrong(
                            notification: "Vui lòng chọn địa điểm làm việc",
                          );
                        });
                    return;
                  }
                  if (context
                          .read<ImagesPlaceCubitForJobPosting>()
                          .state
                          .length ==
                      0) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWrong(
                            notification: "Vui lòng thêm 1 vài ảnh",
                          );
                        });
                    return;
                  }
                  PostJobInfo postJobInfo = PostJobInfo(
                    images: cubit.images,
                    longitude:
                        context.read<SaveAddressCubit>().state!.longitude,
                    latitude: context.read<SaveAddressCubit>().state!.latitude,
                    workingAddress:
                        context.read<SaveAddressCubit>().state?.address,
                    title: titleController.text,
                    numberEmployee: int.parse(numberEmployeeController.text),
                    description: desController.text,
                    wageType: selectedValue,
                    // wageTypeDisplay: wageTypeDisplayController.text,
                    wageMin: double.parse(wageMinController.text),
                    wageMax: double.parse(wageMaxController.text),
                    candidateGender: candidateGenderController.text,
                    candidateMinAge: int.parse(candidateMinAgeController.text),
                    candidateMaxAge: int.parse(candidateMaxAgeController.text),
                    candidateExperience: candidateExpController.text,
                  );
                  final userCode = context.read<UserCubit>().state.code;
                  context.read<PostJobCubit>().postJob(userCode!, postJobInfo,
                      context.read<ImagesPlaceCubitForJobPosting>().state);
                  print(postJobInfo.toJson().toString());
                }
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
