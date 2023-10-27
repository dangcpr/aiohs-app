import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LocationInfoCleaningHourly extends StatefulWidget {
  const LocationInfoCleaningHourly({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<LocationInfoCleaningHourly> createState() =>
      _LocationInfoCleaningHourlyState();
}

class _LocationInfoCleaningHourlyState
    extends State<LocationInfoCleaningHourly> {
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
              "90 Nguyễn Lâm, Phường 6 , Quận 3",
              style: TextStyle(
                fontSize: fontSize.mediumLarger,
                fontFamily: fontBoldApp,
                color: colorProject.primaryColor,
              ),
            ),
            Text(
              "Nhà riêng",
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Chi tiết địa chỉ",
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
                    "Nguyễn Hải Đăng",
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
                    "0123456789",
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
                    "90 Nguyễn Lâm, Phường 6 , Quận 3, Thành phố Hồ Chí Minh",
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
