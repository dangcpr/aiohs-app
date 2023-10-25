import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CustomProgressIndicator extends StatefulWidget {
  CustomProgressIndicator({required this.limitedRadius});

  final double limitedRadius;
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  final double initialRadius = 30.0;
  double radius = 0.0;
  double circleRadius = 15;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        // start animation at 4*0.75st s end end at 4*1st s.
        // and animationController will have a value between 0.75 and 1 in
        // during this time period
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );
    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );
    animationController.addListener(() {
      setState(() {
        if (animationController.value >= 0.75 &&
            animationController.value <= 1.0) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (animationController.value >= 0.0 &&
            animationController.value <= 0.25) {
          radius = animationRadiusOut.value * widget.limitedRadius;
        }
        circleRadius = 15 - animationController.value * 15;
      });
    });

    //start animation
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        // flip vertical descartes
        // default alignment by top - left
        child: RotationTransition(
          turns: animationRotation,
          child: Stack(
            children: [
              // pair
              Transform.translate(
                offset: Offset(radius * cos(pi), radius * sin(pi)), // -1,0
                child: _Dot(
                  radius: circleRadius,
                  color: colorProject.primaryColor,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * -cos(pi), radius * sin(pi)), // 1,0
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFFCC99C9),
                ),
              ),
              // pair
              Transform.translate(
                offset: Offset(radius * cos(3 * pi / 4),
                    radius * sin(3 * pi / 4)), //-sqrt(2)/2, -sqrt(2)/2
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFF9EC1CF),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    radius * cos(3 * pi / 4), radius * -sin(3 * pi / 4)), // 1,0
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFF9EE09E),
                ),
              ),
              // pair
              Transform.translate(
                offset: Offset(radius * cos(pi / 2),
                    radius * sin(pi / 2)), //-sqrt(2)/2, -sqrt(2)/2
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFFFDFD97),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(pi / 2), radius * -sin(pi / 2)), // 1,0
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFFFEB144),
                ),
              ),
              // pair
              Transform.translate(
                offset: Offset(radius * cos(pi / 4),
                    radius * sin(pi / 4)), //-sqrt(2)/2, -sqrt(2)/2
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFFFF6663),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(pi / 4), radius * -sin(pi / 4)), // 1,0
                child: _Dot(
                  radius: circleRadius,
                  color: Color(0xFFFD63B0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  _Dot({required this.radius, required this.color});

  final double radius;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
