import 'package:flutter/material.dart';

IconData getIcon(String code) {
  switch (code) {
    case 'CLEAN_ON_DEMAND': return Icons.access_alarm;
    case 'CLEAN_SUBSCRIPTION': return Icons.cleaning_services;
    case 'HOME_COOKING': return Icons.cookie;
    case 'GROCERY_ASSISTANT' : return Icons.shopping_cart;
    case 'LAUNDRY': return Icons.local_laundry_service;
    case 'AIR_CONDITIONING_CLEAN': return Icons.ac_unit_outlined;
    default: return Icons.cleaning_services;
  }
}