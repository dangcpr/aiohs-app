import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/place_page/views/place_detail.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LocationCard extends StatefulWidget {
  const LocationCard(
      {super.key, required this.rentalPlace, this.isUser = false});

  final List<RentalPlaceRes> rentalPlace;
  final bool isUser;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.rentalPlace.length.toString());
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            widget.rentalPlace.length,
            (index) => Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    debugPrint("tapped" + widget.rentalPlace[index].title);
                    Navigator.push(
                      context,
                      PageTransition(
                        child: PlaceDetailScreen(
                          rentalPlace: widget.rentalPlace[index],
                          isUser: widget.isUser,
                        ),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: Card(
                    size,
                    widget.rentalPlace[index].title,
                    widget.rentalPlace[index].address,
                    widget.rentalPlace[index].images[0],
                    widget.rentalPlace[index].price,
                    widget.rentalPlace[index].type_display,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container Card(Size size, String title, String address, String image,
      int price, String state) {
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
          Image.network(
            image,
            height: size.height / 5,
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: [
          //       Icon(
          //         Icons.lock,
          //         color: colorProject.primaryColor,
          //       ),
          //       SizedBox(width: 5),
          //       Text(
          //         state,
          //         style: TextStyle(
          //           fontFamily: fontApp,
          //           fontSize: fontSize.medium,
          //           color: Colors.black,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
