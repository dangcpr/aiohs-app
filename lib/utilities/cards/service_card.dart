import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

// ignore: must_be_immutable
class ServiceCard extends StatefulWidget {
  final IconData icon;
  final double width;
  Color? color;
  final String text;
  Function()? onPressed;
  ServiceCard({
    Key? key,
    required this.icon,
    required this.width,
    this.color,
    required this.text,
    this.onPressed
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: widget.color ?? colorProject.primaryColor,
                
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: colorProject.primaryColor.withOpacity(0.25),
                //     blurRadius: 20,
                //     spreadRadius: 1,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontFamily: fontApp,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
