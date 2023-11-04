import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetAddress extends StatefulWidget {
  const BottomSheetAddress({super.key, required this.isDarkMode});

  final bool isDarkMode;

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
                  if (value.length != 10) {
                    return AppLocalizations.of(context)!.signupPhone10Chacs;
                  }
                  if (value.substring(0, 1) != "0") {
                    return "Không đúng định dạng số điện thoại";
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