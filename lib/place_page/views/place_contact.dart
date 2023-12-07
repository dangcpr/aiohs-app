import 'package:flutter/material.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/utilities/components/button_green.dart';

class PlaceContact extends StatefulWidget {
  const PlaceContact({super.key, required this.rentalPlace});

  final RentalPlaceRes rentalPlace;

  @override
  State<PlaceContact> createState() => _PlaceContactState();
}

class _PlaceContactState extends State<PlaceContact> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        width: double.infinity,
        child: ButtonGreenApp(
          label: "Liên hệ",
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (builder) {
                return Container(
                  //height: size.height / 3,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // InfoLine(
                      //   title: 'Họ và tên: ',
                      //   content: widget.rentalPlace.name,
                      //   icon: Icons.person,
                      // ),
                      // SizedBox(height: 8),
                      // InfoLine(
                      //   title: 'Số điện thoại: ',
                      //   content: widget.rentalPlace.phone
                      //       .toString(),
                      //   icon: Icons.phone,
                      // ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        child: ButtonGreenApp(
                          label: "Chat với người cho thuê",
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
