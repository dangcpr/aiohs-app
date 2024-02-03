import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/views/show_address_maps.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({super.key, required this.address, this.inUseCase = false});

  final AddressResponse address;
  final bool inUseCase;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            ListTile(
              focusColor: Colors.grey,
              onTap: () {
                if (widget.inUseCase == false) {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ShowAddressUser(
                        address: widget.address,
                      ),
                    ),
                  );
                } else {
                  debugPrint(widget.address.district);
                  context
                      .read<SaveAddressCubit>()
                      .setAddressFromRes(widget.address);

                  context
                      .read<SaveAddressShoppingCubit>()
                      .setAddressFromRes(widget.address);

                  Navigator.pop(context);
                }
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
        ),
        if (widget.address.is_default == true)
          Icon(Icons.check_circle, color: colorProject.primaryColor, size: 30),
      ],
    );
  }
}
