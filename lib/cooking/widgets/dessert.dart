import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../cubit/save_info_cooking.dart';

class Dessert extends StatefulWidget {
  const Dessert({super.key});

  @override
  State<Dessert> createState() => _DessertState();
}

class _DessertState extends State<Dessert> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = context.read<SaveInfoCookingCubit>().state.fruit;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trái cây',
              style: textStyle.normalStyle(fontSize: 16),
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  activeColor: colorProject.primaryColor,
                  value: isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitched = value;
                      context.read<SaveInfoCookingCubit>().state.fruit = value;
                      print(context.read<SaveInfoCookingCubit>().state.fruit);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
