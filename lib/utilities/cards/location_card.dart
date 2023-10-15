import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        Card(size),
        Card(size),
        Card(size),
        Card(size),
        Card(size),
        Card(size),
      ],
    );
  }

  Container Card(Size size) {
    return Container(
      height: size.height / 4,
      width: size.height / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorProject.primaryColor.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/location.png',
              height: 120,
            ),
            const Text(
              'Cho thuê phòng...',
              style: TextStyle(
                fontFamily: fontBoldApp,
                color: Colors.black,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: colorProject.primaryColor,
                ),
                Text(
                  'Quận 3...',
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Text(
              "Từ 2.000.000 VND",
              style: TextStyle(
                fontFamily: fontApp,
                fontSize: 12,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
