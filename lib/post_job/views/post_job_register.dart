import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/post_job/constants/sex_choose.dart';
import 'package:rmservice/post_job/views/post_job_confirm.dart';
import 'package:rmservice/post_job/widgets/image_list_and_button.dart';
import 'package:rmservice/post_job/constants/salary_method.dart';
import 'package:rmservice/post_job/views/maps.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/text_label.dart';

class PostJobRegister extends StatefulWidget {
  const PostJobRegister({super.key});

  @override
  State<PostJobRegister> createState() => _PostJobRegisterState();
}

class _PostJobRegisterState extends State<PostJobRegister> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  String selectedValue = "h";
  int indexSex = 0;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    nameController.text = (context.read<UserCubit>().state.full_name == "" ||
            context.read<UserCubit>().state.full_name == null
        ? ""
        : context.read<UserCubit>().state.full_name)!;
    phoneController.text =
        (context.read<UserCubit>().state.phone_number == "" ||
                context.read<UserCubit>().state.phone_number == null
            ? ""
            : context.read<UserCubit>().state.phone_number)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng tin giúp việc (Bước 1/2)",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            fontFamily: fontBoldApp,
          ),
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
              TextLabel(
                label: "THÔNG TIN CÁ NHÂN",
                isDarkMode: darkMode,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: nameController,
                  isDarkMode: darkMode,
                  hintText: "Họ và tên người đại diện",
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: phoneController,
                  isDarkMode: darkMode,
                  hintText: "Số điện thoại",
                ),
              ),
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
                          context.watch<SaveAddressCubit>().state!.address == ""
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
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: titleController,
                  isDarkMode: darkMode,
                  hintText: "Số lượng tuyển dụng",
                ),
              ),
              TextFieldLong(
                height: 125,
                controller: detailController,
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
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: titleController,
                  isDarkMode: darkMode,
                  hintText: "Lương tối thiểu (VNĐ)",
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: titleController,
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
                      selectedColor: colorProject.primaryColor.withOpacity(0.4),
                      label: Text(
                        sexList[index],
                        style: TextStyle(fontFamily: fontBoldApp),
                      ),
                      selected: indexSex == index,
                      onSelected: (bool selected) {
                        setState(() {
                          indexSex = (selected ? index : null)!;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: titleController,
                  isDarkMode: darkMode,
                  hintText: "Độ tuổi tối thiểu",
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: titleController,
                  isDarkMode: darkMode,
                  hintText: "Độ tuổi tối đa",
                ),
              ),
              TextFieldLong(
                height: 125,
                controller: detailController,
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
        child: ButtonGreenApp(label: "Tiếp theo", onPressed: () {
          if(formKey.currentState!.validate()) {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: PostJobConfirm(),
              )
            );
          }
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
