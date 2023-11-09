import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../footer.dart';
import 'animated_container.dart';

class TreoTuong extends StatefulWidget {
  const TreoTuong({super.key});

  @override
  State<TreoTuong> createState() => _TreoTuongState();
}

class _TreoTuongState extends State<TreoTuong> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContanierTreoTuongCustom(
          text: 'Dưới 2HP',
        ),
        sizedBox.largeHeight(),
        AnimatedContanierTreoTuongCustom(
          text: 'Trên 2HP',
        ),
        sizedBox.largeHeight(),
        Footer(),
      ],
    );
  }
}
