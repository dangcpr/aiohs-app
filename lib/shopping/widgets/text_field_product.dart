import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/models/product_buy.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFieldProduct extends StatefulWidget {
  const TextFieldProduct({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<TextFieldProduct> createState() => _TextFieldProductState();
}

class _TextFieldProductState extends State<TextFieldProduct> {
  TextEditingController controller = TextEditingController();
  List<File> listImage = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontFamily: fontApp,
            ),
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            expands: true,
            cursorColor: colorProject.primaryColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    width: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colorProject.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText:
                  AppLocalizations.of(context)!.shoppingHintLabelProductField,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: colorProject.primaryColor,
                ),
                onPressed: () {
                  if (controller.text.isEmpty) {
                    return;
                  }
                  ProductBuy product =
                      ProductBuy(name: controller.text, listImages: listImage);
                  context.read<AddItemCubit>().addItem(product);
                  context
                      .read<SaveDataShopping>()
                      .setItems(context.read<AddItemCubit>().state);

                  controller.text = "";
                  debugPrint("Press add item");
                  setState(() {
                    listImage = [];
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        imageAndListButton(),
      ],
    );
  }

  Widget imageAndListButton() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowMultiple: true,
              allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
            );

            // if (result != null) {
            //   List<File> fileAdd =
            //       result.paths.map((path) => File(path!)).toList();
            //   setState(() {
            //     files.insertAll(0, fileAdd);
            //     for (int i = 0; i < files.length; i++) {
            //       context
            //           .read<SaveInfoJobPostingCubit>()
            //           .state
            //           .images
            //           .add(files[i].path);
            //     }
            //   });
            //   debugPrint(files.length.toString());
            // } else {
            //   return;
            // }
            if (result != null) {
              List<File> fileAdd =
                  result.paths.map((path) => File(path!)).toList();
              setState(() {
                listImage.insertAll(0, fileAdd);
              });
              debugPrint(listImage.length.toString());
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
                for (int i = 0; i < listImage.length; i++)
                  ImageList(listImage[i])
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
                    listImage.remove(images);
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
