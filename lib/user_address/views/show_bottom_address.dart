// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/user_address/constants/choose_type_of_address.dart';
import 'package:rmservice/user_address/cubits/get_user_address/get_user_address.dart';
import 'package:rmservice/user_address/helpers/user_address_helper.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class BottomSheetAddressUser extends StatefulWidget {
  const BottomSheetAddressUser({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<BottomSheetAddressUser> createState() => _BottomSheetAddressUserState();
}

class _BottomSheetAddressUserState extends State<BottomSheetAddressUser> {
  final nameAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isDefault = false;
  String _value = chooseTypeOfAddress[0].value;

  @override
  void initState() {
    super.initState();
    nameAddress.text = context.read<SaveAddressCubit>().state!.shortAddress!;

    isDefault =
        context.read<GetUserAddressCubit>().state.isEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    //controller.text = context.read<SavePriceShopping>().state.toString()
    bool isDarkMode = widget.isDarkMode;
    var addressCubit = context.read<SaveAddressCubit>();
    var userCubit = context.read<UserCubit>();

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
            TextFieldBasic(
              controller: nameAddress,
              isDarkMode: isDarkMode,
              hintText: "Tên địa điểm",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.signupEmptyError;
                } else {
                  return null;
                }
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đây là địa chỉ mặc định',
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    fontFamily: fontApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
                Switch(
                  value: isDefault,
                  activeColor: colorProject.primaryColor,
                  onChanged: (value) {
                    if (value == false &&
                        context.read<GetUserAddressCubit>().state.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogWrong(
                          notification:
                              "Vì bạn chưa có địa chỉ đã lưu nên địa chỉ phải là mặc định",
                        ),
                      );
                      return;
                    }
                    setState(() {
                      isDefault = value;
                      debugPrint(isDefault.toString());
                    });
                  },
                ),
              ],
            ),
            Text(
              'Loại địa chỉ',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
                fontFamily: fontApp,
                fontSize: fontSize.mediumLarger,
              ),
            ),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                3,
                (int index) {
                  return ChoiceChip(
                    checkmarkColor: _value == chooseTypeOfAddress[index].value
                        ? Colors.white
                        : Colors.black,
                    selectedColor: colorProject.primaryColor,
                    labelStyle: TextStyle(
                      color: _value == chooseTypeOfAddress[index].value
                          ? Colors.white
                          : Colors.black,
                      fontFamily: _value == chooseTypeOfAddress[index].value
                          ? fontBoldApp
                          : fontApp,
                    ),
                    label: Text(
                      chooseTypeOfAddress[index].name,
                    ),
                    selected: _value == chooseTypeOfAddress[index].value,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected
                            ? chooseTypeOfAddress[index].value
                            : chooseTypeOfAddress[0].value;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Xác nhận",
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  addressCubit.state!.typeOfAddress = _value;
                  addressCubit.state!.shortAddress = nameAddress.text;
                  debugPrint("Xác nhận địa chỉ");
                  debugPrint(addressCubit.state!.toJson().toString() +
                      ' ' +
                      isDefault.toString());

                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorProject.primaryColor,
                        ),
                      );
                    },
                  );
                  try {
                    await UserAddressHelper().addAddressAndGetAddress(
                      addressCubit.state!,
                      userCubit.state.code!,
                      isDefault,
                      context,
                    );
                    //show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colorProject.primaryColor,
                        content: Text('Địa chỉ đã được lưu thành công',
                            style: TextStyle(
                              fontFamily: fontApp,
                              fontSize: fontSize.medium,
                            )),
                        action: SnackBarAction(
                            label: 'Đóng',
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWrong(notification: e.toString());
                      },
                    );
                  }

                  _formKey.currentState!.save();
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
