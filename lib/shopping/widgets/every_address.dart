import 'package:flutter/material.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/utilities/constants/check_type_of_address.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EveryAddressShopping extends StatefulWidget {
  const EveryAddressShopping(
      {super.key,
      required this.isDarkMode,
      required this.addressShopping,
      });

  final bool isDarkMode;
  final AddressShopping addressShopping;

  @override
  State<EveryAddressShopping> createState() => _EveryAddressShoppingState();
}

class _EveryAddressShoppingState extends State<EveryAddressShopping> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.addressShopping.nameAddress!,
              style: TextStyle(
                fontSize: fontSize.mediumLarger,
                fontFamily: fontBoldApp,
                color: colorProject.primaryColor,
              ),
            ),
            Text(
              checkTypeOfAddress(widget.addressShopping.typeOfAddress!, context),
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.locationDetailLabel,
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.addressShopping.yourName!,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.addressShopping.phoneNum!,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.addressShopping.fullAddress!,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                  color: colorProject.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
