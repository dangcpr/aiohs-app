import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class EmptyAddress extends StatefulWidget {
  const EmptyAddress({super.key});

  @override
  State<EmptyAddress> createState() => _EmptyAddressState();
}

class _EmptyAddressState extends State<EmptyAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Image.asset(
          'assets/images/Empty-bro.png',
        ),
        Text(
          "Không có địa chỉ đã lưu",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.large,
            color: colorProject.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Không tồn tại địa chỉ đã lưu của bạn. Vui lòng thêm địa chỉ mới bên dưới.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontApp,
            fontSize: fontSize.medium,
            color: colorProject.subColor,
          ),
        ),
      ],
    ));
  }
}
