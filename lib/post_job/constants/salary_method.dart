import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownSalaryMethod {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Theo giờ"), value: "WAGE_TYPE_HOURLY"),
    DropdownMenuItem(child: Text("Theo ngày"), value: "WAGE_TYPE_DAILY"),
    DropdownMenuItem(child: Text("Theo tháng"), value: "WAGE_TYPE_MONTHLY"),
    DropdownMenuItem(child: Text("Lương khoán"), value: "WAGE_TYPE_JOB_AMOUNT"),
  ];
  return menuItems;
}
