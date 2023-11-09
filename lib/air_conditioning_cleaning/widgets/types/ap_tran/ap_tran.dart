import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../footer.dart';
import 'animated_container.dart';

class ApTran extends StatefulWidget {
  const ApTran({super.key});

  @override
  State<ApTran> createState() => _ApTranState();
}

class _ApTranState extends State<ApTran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContanierApTranCustom(
          text: 'Dưới 5HP',
        ),
        sizedBox.largeHeight(),
        AnimatedContanierApTranCustom(
          text: 'Trên 5HP',
        ),
        sizedBox.largeHeight(),
        Footer(),
      ],
    );
  }
}
