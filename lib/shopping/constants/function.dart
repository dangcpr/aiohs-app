import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String checkTypeOfAddress(int number, BuildContext context) {
  switch (number) {
    case 1:
      return AppLocalizations.of(context)!.typeOfAddress1;
    case 2:
      return AppLocalizations.of(context)!.typeOfAddress2;
    case 3:
      return AppLocalizations.of(context)!.typeOfAddress3;
    default:
      return AppLocalizations.of(context)!.typeOfAddressUnknown;
  }
}