import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ImageListAndButton extends StatefulWidget {
  const ImageListAndButton({super.key});

  @override
  State<ImageListAndButton> createState() => _ImageListAndButtonState();
}

class _ImageListAndButtonState extends State<ImageListAndButton> {
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowMultiple: true,
              allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
            );

            if (result != null) {
              List<File> fileAdd =
                  result.paths.map((path) => File(path!)).toList();
              setState(() {
                files.insertAll(0, fileAdd);
              });
              debugPrint(files.length.toString());
            } else {
              return;
            }
          },
          child: Column(
            children: [
              SizedBox(height: 10),
              Icon(Icons.file_upload, color: colorProject.primaryColor),
              Text(
                "Thêm ảnh",
                style: TextStyle(
                  color: colorProject.primaryColor,
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.medium,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < files.length; i++) ImageList(files[i])
              ],
            ),
          ),
        )
      ],
    );
  }

  Container ImageList(File images) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 10),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                child: Center(
                  child: Image.file(
                    images,
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
              InkWell(
                  child: Icon(Icons.cancel),
                  onTap: () {
                    setState(() {
                      files.remove(images);
                    });
                  })
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
