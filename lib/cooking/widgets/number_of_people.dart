import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class NumberOfPeople extends StatefulWidget {
  const NumberOfPeople({super.key});

  @override
  State<NumberOfPeople> createState() => _NumberOfPeopleState();
}

class _NumberOfPeopleState extends State<NumberOfPeople> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveInfoCookingCubit>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorProject.primaryColor),
              ),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      cubit.state.numberOfPeople--;
                      if (cubit.state.numberOfPeople <= 1)
                        cubit.state.numberOfPeople = 1;
                    });
                  },
                  child: Icon(Icons.remove)),
            ),
            Text(
              cubit.state.numberOfPeople.toString(),
              style: textStyle.headerStyle(fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorProject.primaryColor),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    cubit.state.numberOfPeople++;
                  });
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
