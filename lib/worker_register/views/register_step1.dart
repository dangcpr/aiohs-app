import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_register/controllers/extract_id.dart';
import 'package:rmservice/worker_register/models/extract_id.dart';
import 'package:rmservice/worker_register/views/register_step2.dart';

class WorkerRegisterStep1Screen extends StatefulWidget {
  const WorkerRegisterStep1Screen({super.key});

  @override
  State<WorkerRegisterStep1Screen> createState() =>
      _WorkerRegisterStep2ScreenState();
}

class _WorkerRegisterStep2ScreenState extends State<WorkerRegisterStep1Screen> {
  File? idF;
  File? idB;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trở thành người giúp việc (Bước 1/2)",
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
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "Bạn muốn trở thành người giúp việc",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Hoàn thành các thông tin bên dưới để đăng ký, chúng tôi sẽ liên hệ bạn để trả kết quả sau 48h làm việc",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
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

            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.bottomSlide,
              showCloseIcon: true,
              title: 'Bạn có muốn rút trích dữ liệu từ CCCD?',
              desc:
                  'Các thông tin sẽ tự động điền ở bước sau và bạn không thể sửa chúng.',
              btnOkOnPress: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: colorProject.primaryColor),
                      );
                    });
                try {
                  ExtractIDCard extractIDCard =
                      await ExtractIDCardController().extractIDCard(idF!, idB!);
                  debugPrint(extractIDCard.toJson().toString());
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: WorkerRegisterStep2Screen(
                        identity_front_image_url: idF!,
                        identity_back_image_url: idB!,
                        full_name: extractIDCard.full_name,
                        identiny_no: extractIDCard.identiny_no,
                        issue_on: extractIDCard.issue_on,
                        permanent_address: extractIDCard.permanent_address,
                        date_of_birth: extractIDCard.date_of_birth,
                        place_of_birth: extractIDCard.place_of_birth,
                      ),
                    ),
                  );
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Có lỗi xảy ra khi rút trích',
                    titleTextStyle: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                      color: Colors.red,
                    ),
                    desc: e.toString(),
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
              btnCancelOnPress: () {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: WorkerRegisterStep2Screen(
                      identity_front_image_url: idF!,
                      identity_back_image_url: idB!,
                    ),
                  ),
                );
              },
            ).show();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
