import 'package:flutter/material.dart';
import 'package:rmservice/air_conditioning_cleaning/widgets/footer.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import 'animated_container.dart';

class TuDung extends StatefulWidget {
  const TuDung({super.key});

  @override
  State<TuDung> createState() => _TuDungState();
}

class _TuDungState extends State<TuDung> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContanierTuDungCustom(
          text: 'Portable',
        ),
        sizedBox.largeHeight(),
        // Footer(),
      ],
    );
  }
}
