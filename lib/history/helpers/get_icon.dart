import 'package:flutter/material.dart';

String getIcon(String code) {
  switch (code) {
    case 'CLEAN_ON_DEMAND':
      return 'assets/images/cleaning_hourly.png';
    case 'CLEAN_SUBSCRIPTION':
      return 'assets/images/cleaning_longterm.png';
    case 'HOME_COOKING':
      return 'assets/images/cooking.png';
    case 'GROCERY_ASSISTANT':
      return 'assets/images/shopping.png';
    case 'LAUNDRY':
      return 'assets/images/washing.png';
    case 'AIR_CONDITIONING_CLEAN':
      return 'assets/images/air_conditioner.png';
    default:
      return 'assets/images/cleaning_hourly.png';
  }
}
