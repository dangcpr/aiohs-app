import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/place_page/constants/test_place.dart';
import 'package:rmservice/place_page/models/rental_place.dart';
import 'package:rmservice/place_page/views/place_detail.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  List<RentalPlace> testListRentalPlace1 = testListRentalPlace;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(
          testListRentalPlace1.length,
          (index) => Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  debugPrint("tapped" + testListRentalPlace1[index].titleRent);
                  Navigator.push(
                    context,
                    PageTransition(
                      child: PlaceDetailScreen(
                        rentalPlace: testListRentalPlace1[index],
                      ),
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: Duration(milliseconds: 400),
                    ),
                  );
                },
                child: Card(
                  size,
                  testListRentalPlace1[index].titleRent,
                  testListRentalPlace1[index].address,
                  testListRentalPlace1[index].images[0],
                  testListRentalPlace1[index].price,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Container Card(
      Size size, String title, String address, String image, int price) {
    return Container(
      width: size.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(0.25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/location.png',
            height: size.height / 3.5,
            width: size.width,
          ),
          Divider(height: 1, indent: 0, endIndent: 0),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger + 2,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  Icons.money,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 5),
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(price),
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.medium,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
