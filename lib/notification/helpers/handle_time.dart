import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String handleTime(BuildContext context, String date) {
  //String locale = Localizations.localeOf(context).languageCode;

  DateTime time = DateTime.parse(date);
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

  // time - now to second
  //int timeToSecond = time.difference(time).inSeconds;
  int difference = now.difference(time).inSeconds;
  debugPrint(difference.toString());

  if(difference < 60) {
    return '${difference} giây trước';
  } else if(difference >= 60 && difference < 60 * 60) {
    return '${difference ~/ 60} phút trước';
  } else if(difference >= 60 * 60 && difference < 60 * 60 * 24) {
    return '${difference ~/ (60 * 60)} giờ trước'; 
  } else {
    return dateFormat.format(DateTime.parse(date));
  }
}