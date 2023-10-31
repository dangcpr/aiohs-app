import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/widgets/dialog_wrong.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_field_basic.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetAddress extends StatefulWidget {
  const BottomSheetAddress({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<BottomSheetAddress> createState() => _BottomSheetAddressState();
}

class _BottomSheetAddressState extends State<BottomSheetAddress> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //controller.text = context.read<SavePriceShopping>().state.toString();

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
            SizedBox(
              height: 55,
              child: TextFieldBasic(
                controller: nameController,
                isDarkMode: widget.isDarkMode,
                hintText: "Họ và tên",
                onChanged: (value) {
                  debugPrint(value);
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 55,
              child: TextFieldBasic(
                controller: nameController,
                isDarkMode: widget.isDarkMode,
                hintText: "Họ và tên",
                onChanged: (value) {
                  debugPrint(value);
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Xác nhận",
                onPressed: () {
                  debugPrint("Xác nhận số tiền");
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
