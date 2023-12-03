import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetAddress extends StatefulWidget {
  const BottomSheetAddress({super.key, required this.isDarkMode, required this.lat, required this.lng});

  final bool isDarkMode;
  final double lat;
  final double lng;

  @override
  State<BottomSheetAddress> createState() => _BottomSheetAddressState();
}

class _BottomSheetAddressState extends State<BottomSheetAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shortAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //controller.text = context.read<SavePriceShopping>().state.toString();
    shortAddressController.text =
        context.read<SaveAddressCubit>().state!.shortAddress!;
    nameController.text =
        (context.read<SaveAddressCubit>().state!.name != null &&
                context.read<SaveAddressCubit>().state!.name!.isNotEmpty
            ? context.read<SaveAddressCubit>().state!.name
            : (context.read<UserCubit>().state.full_name == null ||
                    context.read<UserCubit>().state.full_name!.isEmpty
                ? ""
                : context.read<UserCubit>().state.full_name)!)!;
    phoneController.text =
        (context.read<SaveAddressCubit>().state!.phone != null &&
                context.read<SaveAddressCubit>().state!.phone!.isNotEmpty
            ? context.read<SaveAddressCubit>().state!.phone
            : (context.read<UserCubit>().state.phone_number == null ||
                    context.read<UserCubit>().state.phone_number!.isEmpty
                ? ""
                : context.read<UserCubit>().state.phone_number)!)!;
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).viewInsets.top + 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextLabel(
              label: "Hoàn thành thông tin bên dưới để xác nhận địa chỉ",
              isDarkMode: widget.isDarkMode,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFieldBasic(
                controller: nameController,
                isDarkMode: widget.isDarkMode,
                hintText: AppLocalizations.of(context)!.signupName,
                onChanged: (value) {
                  debugPrint(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    //debugPrint("Lỗi họ và tên");
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  return null;
                },
              ),
            ),
            //SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFieldBasic(
                controller: phoneController,
                isDarkMode: widget.isDarkMode,
                hintText: "Số điện thoại",
                onChanged: (value) {
                  debugPrint(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    //debugPrint("Lỗi họ và tên");
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  // if (value.length != 10) {
                  //   return AppLocalizations.of(context)!.signupPhone10Chacs;
                  // }
                  if (value.substring(0, 1) != "0" && value.substring(0, 1) != "+") {
                    return "Ký tự bắt đầu phải là 0 hoặc +";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFieldBasic(
                controller: shortAddressController,
                isDarkMode: widget.isDarkMode,
                hintText: "Tên địa điểm",
                onChanged: (value) {
                  debugPrint(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    //debugPrint("Lỗi họ và tên");
                    return AppLocalizations.of(context)!.signupEmptyError;
                  }
                  return null;
                },
              ),
            ),
            //SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Xác nhận",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint("Xác nhận địa chỉ");
                    context.read<SaveAddressCubit>().setAddress(
                          Address(
                            name: nameController.text,
                            phone: phoneController.text,
                            address:
                                context.read<SaveAddressCubit>().state!.address,
                            shortAddress: shortAddressController.text,
                            latitude: widget.lat,
                            longitude: widget.lng,
                          ),
                        );

                    Navigator.pop(context);
                    Navigator.pop(context);

                    _formKey.currentState!.save();
                  } else {}
                },
              ),
            ),
            //SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
