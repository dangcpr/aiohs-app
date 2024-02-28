import 'package:flutter/material.dart';
import 'package:rmservice/air_conditioning_cleaning/widgets/footer.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../ap_tran/animated_container.dart';
import 'animated_container.dart';

class Amtran extends StatefulWidget {
  const Amtran({super.key});

  @override
  State<Amtran> createState() => _AmtranState();
}

class _AmtranState extends State<Amtran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContanierCustomAmTran(
          text: 'Below 3HP',
        ),
        sizedBox.largeHeight(),
        AnimatedContanierCustomAmTran(
          text: 'Above 3HP',
        ),
        sizedBox.largeHeight(),
        // Footer(),
      ],
    );
  }
}
