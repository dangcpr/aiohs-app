import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';

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
          hintText: "Nhập ghi chú cho nhân viên",
        ),
        onChanged: (value) {
          context.read<SaveInfoCleaningHourlyCubit>().state.note = value;
        },
      ),
    );
  }
}
