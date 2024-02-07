// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/controllers/place_page.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_cubit.dart';
import 'package:rmservice/place_page/cubits/images_place_cubit.dart';
import 'package:rmservice/place_page/models/rental_place.dart';
import 'package:rmservice/place_page/views/maps.dart';
import 'package:rmservice/utilities/components/text_label.dart';
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
  TextEditingController addressController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  bool haveElevator = false;
  bool isOnTheFloors = false;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    var userCubit = context.read<UserCubit>();

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
          label: Text("Đăng tin",
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
                color: Colors.white,
              )),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              debugPrint(context.read<SaveAddressCubit>().state!.address);
              if (context.read<SaveAddressCubit>().state!.address == "" ||
                  context.read<SaveAddressCubit>().state == null) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.topSlide,
                  title: "Chưa chọn địa điểm",
                  titleTextStyle: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.large,
                    color: Colors.red,
                  ),
                  desc: "Vui lòng chọn địa điểm",
                  descTextStyle: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.medium,
                  ),
                ).show();
                return;
              }
            }

            if (formKey.currentState!.validate()) {
              debugPrint(context.read<SaveAddressCubit>().state!.address);
              if (context.read<ImagesPlaceCubit>().state.isEmpty) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.topSlide,
                  title: "Chưa có hình ảnh chỗ thuê",
                  titleTextStyle: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.large,
                    color: Colors.red,
                  ),
                  desc: "Chưa có hình ảnh chỗ thuê. Vui lòng thêm ảnh.",
                  btnCancelOnPress: () {},
                  descTextStyle: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.medium,
                  ),
                ).show();
              } else {
                RentalPlace rentalPlace = RentalPlace(
                  title: titleController.text,
                  number_rental_days: int.parse(numOfDayController.text),
                  area: double.parse(areaController.text),
                  price: double.parse(priceController.text),
                  description: detailController.text,
                  images: [],
                  address:
                      '${context.read<SaveAddressCubit>().state!.address}',
                  latitude: context.read<SaveAddressCubit>().state!.latitude!,
                  longitude: context.read<SaveAddressCubit>().state!.longitude!,
                  height: double.parse(heightController.text),
                  has_elevator: haveElevator,
                  on_the_floors: isOnTheFloors,
                  city: 'oke',
                  district: 'oke',
                  ward: 'oke',
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: colorProject.primaryColor,
                      ));
                    });
                try {
                  await PlacePageController().createPlaceRental(
                      rentalPlace,
                      userCubit.state.code!,
                      context.read<ImagesPlaceCubit>().state);
                  Navigator.pop(context);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: "Đăng tin thành công",
                    titleTextStyle: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.large,
                      color: Colors.green,
                    ),
                    desc: "Đã đăng tin",
                    descTextStyle: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ).show();
                  context
                      .read<GetPlaceUserCubit>()
                      .getPlaceUser(userCubit.state.code!);
                } catch (e) {
                  Navigator.pop(context);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    title: "Có lỗi xảy ra",
                    titleTextStyle: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.large,
                      color: Colors.red,
                    ),
                    desc: e.toString(),
                    descTextStyle: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ).show();
                }
              }
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.signupEmptyError;
                    }
                    return null;
                  },
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
                        int.tryParse(value)! > 31) {
                      return "Vui lòng nhập số nguyên từ 1 đến 31 (ngày)";
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
                  controller: heightController,
                  isDarkMode: darkMode,
                  hintText: "Chiều cao (m\u00B2)",
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.signupEmptyError;
                      }
                      if (int.tryParse(value) == null ||
                          int.tryParse(value)! <= 100000) {
                        return "Vui lòng nhập số nguyên lớn hơn 100000 (VNĐ)";
                      } else
                        return null;
                    }),
              ),
              TextFieldLong(
                height: 125,
                controller: detailController,
                isDarkMode: darkMode,
                hintText: "Chi tiết về chỗ thuê",
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nơi cho thuê ở trên lầu?',
                    style: textStyle.normalStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 50,
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        activeColor: colorProject.primaryColor,
                        value: isOnTheFloors,
                        onChanged: (bool value) {
                          setState(() {
                            isOnTheFloors = value;
                            print(isOnTheFloors);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nơi cho thuê có thang máy?',
                    style: textStyle.normalStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 50,
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        activeColor: colorProject.primaryColor,
                        value: haveElevator,
                        onChanged: (bool value) {
                          setState(() {
                            haveElevator = value;
                            print(haveElevator);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
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
              SizedBox(
                height: 10,
              ),
              // TextFieldBasic(
              //   controller: addressController,
              //   isDarkMode: darkMode,
              //   hintText: "Tên địa điểm",
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return AppLocalizations.of(context)!.signupEmptyError;
              //     }
              //     if (value.contains("-")) {
              //       return "Tên địa điểm không được chứa dấu -";
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
