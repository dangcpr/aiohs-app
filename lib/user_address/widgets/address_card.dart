import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/views/show_address_maps.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({super.key, required this.address});

  final AddressResponse address;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          focusColor: Colors.grey,
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: ShowAddressUser(
                  address: widget.address,
                )
              )
            );
          },
          leading: Icon(
            widget.address.type == "home"
                ? Icons.home
                : (widget.address.type == "office"
                    ? Icons.work
                    : Icons.apartment),
            color: colorProject.primaryColor,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorProject.primaryColor,
          ),
          title: Text(
            widget.address.detail,
            style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
                color: colorProject.primaryColor),
          ),
          subtitle: Text(
            widget.address.street_name,
            style: TextStyle(
                fontFamily: fontApp,
                fontSize: fontSize.medium,
                color: colorProject.subColor),
          ),
          
        ),
        SizedBox(height: 5),
        Divider(height: 0),
      ],
    );
  }
}
