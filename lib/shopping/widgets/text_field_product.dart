import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            borderSide: BorderSide(color: colorProject.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: AppLocalizations.of(context)!.shoppingHintLabelProductField,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: colorProject.primaryColor,
            ),
            onPressed: () {
              if(controller.text.isEmpty) {
                return;
              }
              context.read<AddItemCubit>().addItem(controller.text);
              controller.text = "";
              debugPrint("Press add item");
            },
          ),
        ),
      ),
    );
  }
}
