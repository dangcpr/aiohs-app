import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../footer.dart';
import 'animated_container.dart';

class GiauTran extends StatefulWidget {
  const GiauTran({super.key});

  @override
  State<GiauTran> createState() => _GiauTranState();
}

class _GiauTranState extends State<GiauTran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContanierGiauTranCustom(
          text: 'Build_in',
        ),
        sizedBox.largeHeight(),
        // Footer(),
      ],
    );
  }
}
