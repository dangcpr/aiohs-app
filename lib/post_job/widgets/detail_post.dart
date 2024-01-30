import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/chat/chat_page.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/post_job/constants/sex_choose.dart';
import 'package:rmservice/post_job/cubits/close_post/close_post_cubit.dart';
import 'package:rmservice/post_job/cubits/save_info_job_posting.dart';
import 'package:rmservice/post_job/views/post_job_screen.dart';
import 'package:rmservice/post_job/views/update_post_screen.dart';
import 'package:rmservice/post_job/constants/salary_method.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/text_label.dart';
import '../models/history_job_posting.dart';
import 'slider.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({super.key, required this.post, required this.tokenChat});

  final HistoryJobPosting post;
  final String tokenChat;

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

  String selectedValue = "WAGE_TYPE_HOURLY";
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

    var userCubit = context.read<UserCubit>();

    var checkEnable = false;
    // widget.post.status == 'active'
    //     ? userCubit.state.code == widget.post.userCode
    //         ? checkEnable = true
    //         : checkEnable = false
    //     : checkEnable = false;
    return BlocListener<ClosePostCubit, ClosePostState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ClosePostLoading) {
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
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Địa chỉ làm việc",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
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
                      label: "Cập nhập bài đăng",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    UpdatePostScreen(post: widget.post)));
                      })
                  : ButtonGreenApp(
                      label: 'Liên hệ người đăng bài',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ChatPage(chatToken: widget.tokenChat)));
                      })
              : Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
