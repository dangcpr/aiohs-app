import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_register/cubits/worker_cubit.dart';
import 'package:rmservice/worker_register/views/register_step3.dart';

class WorkerRegisterStep2Screen extends StatefulWidget {
  const WorkerRegisterStep2Screen({super.key});

  @override
  State<WorkerRegisterStep2Screen> createState() =>
      _WorkerRegisterStep2ScreenState();
}

class _WorkerRegisterStep2ScreenState extends State<WorkerRegisterStep2Screen> {
  File? idF;
  File? idB;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trở thành người giúp việc (Bước 2/3)",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 90),
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: <Widget>[
            TextLabel(
              label: "CMND/CCCD mặt trước",
              isDarkMode: darkMode,
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: idF == null
                  ? Image.asset(
                      "assets/images/identification 1.png",
                    )
                  : Image.file(idF!),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text(
                    "Chọn ảnh",
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                      color: colorProject.primaryColor,
                    ),
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
                    );

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      setState(() {
                        idF = file;
                      });
                      debugPrint(idF.toString());
                    }
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Xóa ảnh",
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                      color: idF == null ? Colors.grey : Colors.red,
                    ),
                  ),
                  onPressed: idF == null
                      ? null
                      : () {
                          setState(() {
                            idF = null;
                          });
                        },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextLabel(
              label: "CMND/CCCD mặt sau",
              isDarkMode: darkMode,
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: idB == null
                  ? Image.asset(
                      "assets/images/identification 1.png",
                    )
                  : Image.file(idB!),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                child: Text(
                  "Chọn ảnh",
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                    color: colorProject.primaryColor,
                  ),
                ),
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      idB = file;
                    });
                    debugPrint(idB.toString());
                  }
                },
              ),
              ElevatedButton(
                child: Text(
                  "Xóa ảnh",
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                    color: idB == null ? Colors.grey : Colors.red,
                  ),
                ),
                onPressed: idB == null
                    ? null
                    : () {
                        setState(() {
                          idB = null;
                        });
                      },
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ButtonGreenApp(
          label: "Tiếp theo",
          onPressed: () {
            if (idF == null || idB == null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification:
                          "Vui lòng tải cả mặt trước và sau của CMND/CCCD",
                    );
                  });
              return;
            }

            context.read<WorkerCubit>().setIDImage(idF!, idB!);

            debugPrint(context.read<WorkerCubit>().state.toJson().toString());

            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: WorkerRegisterStep3Screen(),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
