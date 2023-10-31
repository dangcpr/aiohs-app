import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteForMaid extends StatefulWidget {
  const NoteForMaid({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<NoteForMaid> createState() => _NoteForMaidState();
}

class _NoteForMaidState extends State<NoteForMaid> {
  @override
  Widget build(BuildContext context) {    
    return SizedBox(
      height: 140,
      child: TextField(
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
            borderSide: BorderSide(color: widget.isDarkMode ? Colors.white : Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorProject.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: AppLocalizations.of(context)!.hintForMaidLabel,
        ),
        onChanged: (value) {
          context.read<SaveDataShopping>().state.note = value;
        },
      ),
    );
  }
}
