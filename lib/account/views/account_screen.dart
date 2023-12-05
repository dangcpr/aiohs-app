import 'package:flutter/material.dart';
import 'package:rmservice/account/helpers/account.dart';
import 'package:rmservice/account/widgets/info_account.dart';
import 'package:rmservice/account/widgets/option_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(height: 20),
      InfoAccount(),
      SizedBox(height: 20),
      OptionCard(text: "Chỉnh sửa thông tin", icon: Icons.change_circle),
      OptionCard(
        text: "Địa chỉ đã lưu",
        icon: Icons.location_on,
        onTap: () async {
          AccountHelper().getUserAddress(context);
        }
      ),
    ]);
  }
}
