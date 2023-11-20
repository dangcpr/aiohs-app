import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownSalaryMethod{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Theo giờ"),value: "h"),
    DropdownMenuItem(child: Text("Theo ngày"),value: "d"),
    DropdownMenuItem(child: Text("Theo tháng"),value: "m"),
    DropdownMenuItem(child: Text("Lương khoán"),value: "k"),
  ];
  return menuItems;
}