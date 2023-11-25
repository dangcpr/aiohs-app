import 'package:flutter/material.dart';
import 'package:rmservice/profile/views/profile_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin cá nhân',
            style: textStyle.headerStyle(fontSize: 18)),
      ),
      body: ProfileScreen(),
    );
  }
}
