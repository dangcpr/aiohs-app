import 'dart:ffi';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/login/models/user.dart';
import 'package:rmservice/post_job/constants/sex_choose.dart';
import 'package:rmservice/post_job/cubits/save_info_job_posting.dart';
import 'package:rmservice/post_job/cubits/update_post/update_post_cubit.dart';
import 'package:rmservice/post_job/constants/salary_method.dart';
import 'package:rmservice/post_job/widgets/detail_post.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../chat/controller/chat_controller.dart';
import '../../cleaning_hourly/models/address.dart';
import '../../place_page/controllers/convert_images_to_file.dart';
import '../../place_page/views/maps.dart';
import '../../shopping/widgets/dialog_wrong.dart';
import '../../utilities/components/text_label.dart';
import '../cubits/images_place_cubit.dart';
import '../models/history_job_posting.dart';
import '../models/post_job_info.dart';
import '../widgets/image_list_and_button_update.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key, required this.post});

  final HistoryJobPosting post;

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final formKey = GlobalKey<FormState>();

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
  TextEditingController addressController = TextEditingController();
  List<File> imageList = [];

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

    addressController.text = widget.post.workingAddress;
    context.read<SaveAddressCubit>().setAddress(
          Address(
            latitude: widget.post.latitude.toDouble(),
            longitude: widget.post.longitude.toDouble(),
            shortAddress: widget.post.workingAddress,
            address: widget.post.workingAddress,
            name: context.read<UserCubit>().state.full_name,
          ),
        );

    for (int i = 0; i < widget.post.images.length; i++) {
      urlToFile(widget.post.images[i]).then((value) {
        imageList.add(value);
        setState(() {
          context.read<ImagesPlaceCubitForJobPosting>().setImages(imageList);
        });
      });
    }
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
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    var checkEnable = true;

    return BlocConsumer<UpdatePostCubit, UpdatePostState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdatePostILoading) {
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
        if (state is UpdatePostSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Success",
            desc: 'Update post successfully',
            btnOkOnPress: () async {
              context.read<SaveInfoJobPostingCubit>().setInitial();
              var chatToken = await ChatController().getChatToken(
                  requesterCode:
                      context.read<UserCubit>().state.code.toString(),
                  receiverCode: widget.post.userCode.toString(),
                  title: widget.post.title,
                  postCode: widget.post.code);
              print('chat token: $chatToken');
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPost(
                      post: state.historyJobPosting, tokenChat: chatToken),
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
              Navigator.pop(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Cập nhật tin bài đăng",
              style: TextStyle(
                fontSize: fontSize.mediumLarger,
                fontFamily: fontBoldApp,
              ),
            ),
            leading: InkWell(
              onTap: () async {
                var chatToken = await ChatController().getChatToken(
                    requesterCode:
                        context.read<UserCubit>().state.code.toString(),
                    receiverCode: widget.post.userCode.toString(),
                    title: widget.post.title,
                    postCode: widget.post.code);
                print('chat token: $chatToken');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailPost(post: widget.post, tokenChat: chatToken),
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
                          child: ChooseLocationScreenPlace(),
                        ),
                      );
                    },
                    child: Text(
                      context.watch<SaveAddressCubit>().state!.address == "" ||
                              context.watch<SaveAddressCubit>().state == null
                          ? "Chọn địa điểm"
                          : context.watch<SaveAddressCubit>().state!.address!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: fontBoldApp,
                        fontSize: fontSize.mediumLarger,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
                      hintText: "Lương tối thiểu (VNĐ)",
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: TextFieldBasic(
                      enabled: checkEnable,
                      controller: wageMaxController,
                      isDarkMode: darkMode,
                      keyboardType: TextInputType.number,
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
                  ImageListAndButtonUpdate(),
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
                      keyboardType: TextInputType.number,
                      hintText: "Độ tuổi tối thiểu",
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: TextFieldBasic(
                      enabled: checkEnable,
                      controller: candidateMaxAgeController,
                      isDarkMode: darkMode,
                      keyboardType: TextInputType.number,
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
            child: ButtonGreenApp(
              label: "Lưu thay đổi",
              onPressed: () {
                final cubit = context.read<SaveInfoJobPostingCubit>().state;
                if (formKey.currentState!.validate()) {
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
                    images: [],
                    // longitude: widget.post.longitude,
                    // latitude: widget.post.latitude,
                    longitude:
                        context.read<SaveAddressCubit>().state!.longitude,
                    latitude: context.read<SaveAddressCubit>().state!.latitude,
                    workingAddress:
                        context.read<SaveAddressCubit>().state!.address,
                    title: titleController.text,
                    numberEmployee: int.parse(numberEmployeeController.text),
                    description: desController.text,
                    wageType: selectedValue,
                    // wageTypeDisplay: wageTypeDisplayController.text,
                    wageMin: double.parse(wageMinController.text),
                    wageMax: double.parse(wageMaxController.text),
                    // candidateGender: candidateGenderController.text,
                    candidateMinAge: int.parse(candidateMinAgeController.text),
                    candidateMaxAge: int.parse(candidateMaxAgeController.text),
                    candidateExperience: candidateExpController.text,
                  );
                  final userCode = context.read<UserCubit>().state.code;
                  context.read<UpdatePostCubit>().updatePost(
                        userCode!,
                        postJobInfo,
                        widget.post.code,
                        context.read<ImagesPlaceCubitForJobPosting>().state,
                      );
                  print(postJobInfo.toJson().toString());
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
