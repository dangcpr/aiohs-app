import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class AnimatedContanierTuDungCustom extends StatefulWidget {
  const AnimatedContanierTuDungCustom({super.key, required this.text});

  final String text;

  @override
  State<AnimatedContanierTuDungCustom> createState() =>
      _AnimatedContanierTuDungCustomState();
}

class _AnimatedContanierTuDungCustomState
    extends State<AnimatedContanierTuDungCustom> {
  bool isSwitched = false;
  bool select = false;
  int count = 1;
  late Details detail;
  late int index;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveInfoAirConditioningCleaningCubit>();
    return Center(
      child: AnimatedCrossFade(
        firstChild: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: padding.paddingMedium,
                horizontal: padding.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.text),
                    Icon(Icons.check, color: colorProject.primaryColor),
                  ],
                ),
                sizedBox.largeHeight(),
                Text('Số lượng'),
                sizedBox.mediumHeight(),
                Container(
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
                            border:
                                Border.all(color: colorProject.primaryColor),
                          ),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (count <= 1) {
                                    select = !select;
                                    cubit.removeDetail(detail);
                                  } else {
                                    count--;
                                  }
                                });
                                cubit.state.details[index].amount = count;
                                print(cubit.printListItem);
                              },
                              child: Icon(Icons.remove)),
                        ),
                        Text(
                          count.toString(),
                          style: textStyle.headerStyle(fontSize: 20),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: colorProject.primaryColor),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                count++;
                                cubit.state.details[index].amount = count;
                                print(cubit.printListItem);
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBox.largeHeight(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bơm gas'),
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
                              cubit.state.details[index].hasGas = isSwitched;
                              print(cubit.printListItem);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        secondChild: Container1(),
        duration: const Duration(milliseconds: 300),
        crossFadeState:
            select ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  Widget Container1() {
    var cubit = context.read<SaveInfoAirConditioningCleaningCubit>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorProject.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: padding.paddingMedium, horizontal: padding.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text),
            InkWell(
              onTap: () {
                setState(() {
                  select = !select;
                  detail =
                      cubit.createNewDetail(type: 'Tủ đứng', info: widget.text);
                  index = cubit.checkIndex(detail, cubit.state.details);
                  print(cubit.printListItem);
                });
              },
              child: Icon(Icons.keyboard_arrow_down_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
