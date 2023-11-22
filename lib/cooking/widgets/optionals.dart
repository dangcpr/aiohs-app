import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../cubit/save_info_cooking.dart';

class Optionals extends StatefulWidget {
  const Optionals({super.key});

  @override
  State<Optionals> createState() => _OptionalsState();
}

class _OptionalsState extends State<Optionals> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched1 = context.read<SaveInfoCookingCubit>().state.chooseMaid;
    bool isSwitched2 = context.read<SaveInfoCookingCubit>().state.hasPet;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.fact_check_outlined,
                    color: colorProject.primaryColor),
                sizedBox.mediumWidth(),
                Text(
                  'Bạn tự chọn người làm',
                  style: textStyle.normalStyle(fontSize: 16),
                ),
                sizedBox.smallWidth(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorProject.primaryColor),
                  ),
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 10,
                    color: colorProject.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  activeColor: colorProject.primaryColor,
                  value: isSwitched1,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitched1 = value;
                      context.read<SaveInfoCookingCubit>().state.chooseMaid =
                          value;
                      print(context
                          .read<SaveInfoCookingCubit>()
                          .state
                          .chooseMaid);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.pets, color: colorProject.primaryColor),
                sizedBox.mediumWidth(),
                Text(
                  'Nhà có thú cưng',
                  style: textStyle.normalStyle(fontSize: 16),
                ),
                sizedBox.smallWidth(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorProject.primaryColor),
                  ),
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 10,
                    color: colorProject.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  activeColor: colorProject.primaryColor,
                  value: isSwitched2,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitched2 = value;
                      context.read<SaveInfoCookingCubit>().state.hasPet = value;
                      print(context.read<SaveInfoCookingCubit>().state.hasPet);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
