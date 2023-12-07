import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/place_page/cubits/images_place_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ImageListAndButtonUpdate extends StatefulWidget {
  const ImageListAndButtonUpdate({super.key});

  @override
  State<ImageListAndButtonUpdate> createState() => _ImageListAndButtonUpdateState();
}

class _ImageListAndButtonUpdateState extends State<ImageListAndButtonUpdate> {
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
                context.read<ImagesPlaceCubit>().setImages(files);
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
                    context.read<ImagesPlaceCubit>().setImages(files);
                  });
                },
              )
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
