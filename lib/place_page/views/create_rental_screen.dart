import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_sub_label.dart';
import 'package:rmservice/place_page/widgets/image_list_and_button.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateRentalScreen extends StatefulWidget {
  const CreateRentalScreen({super.key});

  @override
  State<CreateRentalScreen> createState() => _CreateRentalScreenState();
}

class _CreateRentalScreenState extends State<CreateRentalScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numOfDayController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng tin cho thuê chỗ",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: FloatingActionButton.extended(
          backgroundColor: colorProject.primaryColor,
          label: Text(
            "Đăng tin",
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //formKey.currentState!.save();
            }
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "Đăng tin cho thuê chỗ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Hoàn thành các thông tin bên dưới để đăng tin thuê chỗ",
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
                  hintText: "Họ và tên",
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
              TextLabel(
                label: "THÔNG TIN VỀ CHỖ THUÊ",
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
                  controller: numOfDayController,
                  isDarkMode: darkMode,
                  hintText: "Số ngày cho thuê",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    if (int.tryParse(value) == null ||
                        int.tryParse(value)! < 1 ||
                        int.tryParse(value)! > 7) {
                      return "Vui lòng nhập số nguyên từ 1 đến 7 (ngày)";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: areaController,
                  isDarkMode: darkMode,
                  hintText: "Diện tích (m\u00B2)",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    if (double.tryParse(value) == null ||
                        double.tryParse(value)! <= 0) {
                      return "Vui lòng nhập số lớn hơn 0 (m\u00B2)";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: TextFieldBasic(
                  controller: priceController,
                  isDarkMode: darkMode,
                  hintText: "Giá thuê (VNĐ)",
                ),
              ),
              TextFieldLong(
                height: 125,
                controller: detailController,
                isDarkMode: darkMode,
                hintText: "Chi tiết về chỗ thuê",
              ),
              TextLabel(
                label: "Hình ảnh",
                isDarkMode: darkMode,
              ),
              SizedBox(
                height: 10,
              ),
              ImageListAndButton(),
              SizedBox(
                height: 15,
              ),
              TextLabel(
                label: "Địa điểm",
                isDarkMode: darkMode,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Chọn địa điểm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                    color: colorProject.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
