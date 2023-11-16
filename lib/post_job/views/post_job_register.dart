import 'package:flutter/material.dart';

class PostJobRegister extends StatefulWidget {
  const PostJobRegister({super.key});

  @override
  State<PostJobRegister> createState() => _PostJobRegisterState();
}

class _PostJobRegisterState extends State<PostJobRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Post Job Register Screen")),
    );
  }
}