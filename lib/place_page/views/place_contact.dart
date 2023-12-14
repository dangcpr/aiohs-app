import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/utilities/widget/see_maps.dart';
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
        child: Column(
          children: [
            ButtonGreenApp(
              label: "Liên hệ",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (builder) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
            SizedBox(height: 20),
            ButtonGreenApp(
              label: "Địa chỉ trên Google Maps",
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: SeeMapPlace(
                      latitude: widget.rentalPlace.latitude,
                      longtitude: widget.rentalPlace.longitude,
                      title: widget.rentalPlace.title,
                      address: widget.rentalPlace.address,
                    ),
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: Duration(milliseconds: 400),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
