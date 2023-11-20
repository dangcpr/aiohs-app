import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PostJobConfirm extends StatefulWidget {
  const PostJobConfirm({super.key});

  @override
  State<PostJobConfirm> createState() => _PostJobConfirmState();
}

class _PostJobConfirmState extends State<PostJobConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng tin giúp việc (Bước 2/2)",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            fontFamily: fontBoldApp,
          ),
        ),
      ),
      body: Center(child: Text("Post Job Confirm")),
    );
  }
}