import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ButtonChooseLocation extends StatefulWidget {
  const ButtonChooseLocation({
    super.key,
    required this.nameLocation,
    required this.addressLocation,
    required this.isDarkMode,
    this.onPressed,
  });

  final String nameLocation;
  final String addressLocation;
  final bool isDarkMode;
  final void Function()? onPressed;

  @override
  State<ButtonChooseLocation> createState() => _ButtonChooseLocationState();
}

class _ButtonChooseLocationState extends State<ButtonChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          overlayColor: MaterialStateProperty.all(
            colorProject.primaryColor.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: colorProject.primaryColor,
              size: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    widget.nameLocation,
                    style: const TextStyle(
                      color: colorProject.primaryColor,
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.mediumLarger,
                    ),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    widget.addressLocation,
                    style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
