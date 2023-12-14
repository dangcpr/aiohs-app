import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/login/models/user.dart';
import 'package:rmservice/post_job/constants/sex_choose.dart';
import 'package:rmservice/post_job/cubits/close_post/close_post_cubit.dart';
import 'package:rmservice/post_job/cubits/post_job_cubit/post_job_cubit.dart';
import 'package:rmservice/post_job/cubits/save_info_job_posting.dart';
import 'package:rmservice/post_job/cubits/update_post/update_post_cubit.dart';
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
import '../models/history_job_posting.dart';
import '../models/post_job_info.dart';
import 'slider.dart';
import '../views/job_posted.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({super.key, required this.post});

  final HistoryJobPosting post;

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
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
  TextEditingController candidateGenderController = TextEditingController();
  TextEditingController candidateMinAgeController = TextEditingController();
  TextEditingController candidateMaxAgeController = TextEditingController();
  TextEditingController candidateExpController = TextEditingController();

  String selectedValue = "h";
  int indexSex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.post.candidateGender == 'Nam') {
      indexSex = 0;
    } else if (widget.post.candidateGender == 'Nữ') {
      indexSex = 1;
    } else
      indexSex = 2;
  }

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

    titleController.text = widget.post.title;
    numberEmployeeController.text = widget.post.numberEmployee.toString();
    desController.text = widget.post.description;
    wageTypeController.text = widget.post.wageTypeDisplay;
    wageMinController.text = widget.post.wageMin.toString();
    wageMaxController.text = widget.post.wageMax.toString();
    candidateGenderController.text = widget.post.candidateGender;
    candidateMinAgeController.text = widget.post.candidateMinAge.toString();
    candidateMaxAgeController.text = widget.post.candidateMaxAge.toString();
    candidateExpController.text = widget.post.candidateExperience;
    wageTypeDisplayController.text = widget.post.wageTypeDisplay;

    var userCubit = context.read<UserCubit>();

    var checkEnable = true;
    widget.post.status == 'active'
        ? userCubit.state.code == widget.post.userCode
            ? checkEnable = true
            : checkEnable = false
        : checkEnable = false;

    return BlocConsumer<UpdatePostCubit, UpdatePostState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdatePostILoading) {
          Center(
            child: CircularProgressIndicator(
              color: colorProject.primaryColor,
            ),
          );
        }
        if (state is UpdatePostSuccess) {
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
            desc: 'Update post successfully',
            btnOkOnPress: () {
              context.read<SaveInfoJobPostingCubit>().setInitial();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PostJobScreen(),
                ),
              );
            },
          ).show();
        }
        if (state is UpdatePostFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Failed",
            desc: state.message,
            btnOkOnPress: () {
              // Navigator.pop(context);
              context.read<SaveInfoJobPostingCubit>().setInitial();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PostJobScreen(),
                ),
              );
            },
          ).show();
        }
      },
      builder: (context, state) {
        return BlocListener<ClosePostCubit, ClosePostState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ClosePostLoading) {
              Center(
                child: CircularProgressIndicator(
                  color: colorProject.primaryColor,
                ),
              );
            }
            if (state is ClosePostSuccess) {
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
                desc: 'Close post successfully',
                btnOkOnPress: () {
                  context.read<SaveInfoJobPostingCubit>().setInitial();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostJobScreen(),
                    ),
                  );
                },
              ).show();
            }
            if (state is ClosePostFailed) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "Failed",
                desc: state.message,
                btnOkOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostJobScreen(),
                    ),
                  );
                },
              ).show();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Thông tin công việc",
                style: TextStyle(
                  fontSize: fontSize.mediumLarger,
                  fontFamily: fontBoldApp,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostJobScreen(),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back),
              ),
              actions: [
                userCubit.state.code == widget.post.userCode
                    ? widget.post.status == 'active'
                        ? TextButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.topSlide,
                                titleTextStyle: TextStyle(color: Colors.orange),
                                showCloseIcon: true,
                                title: "Warning",
                                desc: 'Bạn có chắc muốn đóng bài đăng không !?',
                                btnOkOnPress: () {
                                  context.read<ClosePostCubit>().closePost(
                                      userCubit.state.code.toString(),
                                      widget.post.code);
                                },
                                btnCancelOnPress: () {},
                              ).show();
                            },
                            child: Text('Đóng bài đăng'),
                          )
                        : Container()
                    : Container(),
              ],
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
                child: ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: [
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
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 85,
                    //   child: TextFieldBasic(
                    //     controller: phoneController,
                    //     isDarkMode: darkMode,
                    //     hintText: "Số điện thoại",
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
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     duration: Duration(milliseconds: 400),
                        //     type: PageTransitionType.rightToLeftWithFade,
                        //     child: ChooseLocationScreen(),
                        //   ),
                        // );
                      },
                      child: Text(
                        // context.watch<SaveAddressCubit>().state == null ||
                        //         context
                        //                 .watch<SaveAddressCubit>()
                        //                 .state!
                        //                 .address ==
                        //             ""
                        //     ? "Chọn địa điểm"
                        //     : context.watch<SaveAddressCubit>().state!.address!,
                        widget.post.workingAddress,
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
                        enabled: checkEnable,
                        controller: titleController,
                        isDarkMode: darkMode,
                        hintText: "Tiêu đề tin",
                      ),
                    ),
                    SizedBox(
                      height: 85,
                      child: TextFieldBasic(
                        enabled: checkEnable,
                        controller: numberEmployeeController,
                        isDarkMode: darkMode,
                        hintText: "Số lượng tuyển dụng",
                      ),
                    ),
                    TextFieldLong(
                      enabled: checkEnable,
                      height: 125,
                      controller: desController,
                      isDarkMode: darkMode,
                      hintText: "Chi tiết về công việc",
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
                        enabled: checkEnable,
                        controller: wageMinController,
                        isDarkMode: darkMode,
                        hintText: "Lương tối thiểu (VNĐ)",
                      ),
                    ),
                    SizedBox(
                      height: 85,
                      child: TextFieldBasic(
                        enabled: checkEnable,
                        controller: wageMaxController,
                        isDarkMode: darkMode,
                        hintText: "Lương tối đa (VNĐ)",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "Hình ảnh nơi làm việc",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    SliderP(
                      urlImages: widget.post.images,
                    ),
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
                        enabled: checkEnable,
                        controller: candidateMinAgeController,
                        isDarkMode: darkMode,
                        hintText: "Độ tuổi tối thiểu",
                      ),
                    ),
                    SizedBox(
                      height: 85,
                      child: TextFieldBasic(
                        enabled: checkEnable,
                        controller: candidateMaxAgeController,
                        isDarkMode: darkMode,
                        hintText: "Độ tuổi tối đa",
                      ),
                    ),
                    TextFieldLong(
                      enabled: checkEnable,
                      height: 125,
                      controller: candidateExpController,
                      isDarkMode: darkMode,
                      hintText: "Yêu cầu kinh nghiệm",
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: widget.post.status != 'inactive'
                  ? userCubit.state.code == widget.post.userCode
                      ? ButtonGreenApp(
                          label: "Cập nhập",
                          onPressed: () {
                            final cubit =
                                context.read<SaveInfoJobPostingCubit>().state;
                            if (formKey.currentState!.validate()) {
                              PostJobInfo postJobInfo = PostJobInfo(
                                images: widget.post.images,
                                // longitude: widget.post.longitude,
                                // latitude: widget.post.latitude,
                                longitude: 0,
                                latitude: 0,
                                workingAddress: widget.post.workingAddress,
                                title: titleController.text,
                                numberEmployee:
                                    int.parse(numberEmployeeController.text),
                                description: desController.text,
                                wageType: selectedValue,
                                // wageTypeDisplay: wageTypeDisplayController.text,
                                wageMin: int.parse(wageMinController.text),
                                wageMax: int.parse(wageMaxController.text),
                                // candidateGender: candidateGenderController.text,
                                candidateMinAge:
                                    int.parse(candidateMinAgeController.text),
                                candidateMaxAge:
                                    int.parse(candidateMaxAgeController.text),
                                candidateExperience:
                                    candidateExpController.text,
                              );
                              final userCode =
                                  context.read<UserCubit>().state.code;
                              context.read<UpdatePostCubit>().updatePost(
                                  userCode!, postJobInfo, widget.post.code);
                              print(postJobInfo.toJson().toString());
                            }
                          })
                      : userCubit.state.role == 'maid'
                          ? ButtonGreenApp(
                              label: 'Liên hệ người đăng bài', onPressed: () {})
                          : Container()
                  : Container(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}